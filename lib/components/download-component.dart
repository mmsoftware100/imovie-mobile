import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/model/our-downalod-task.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-streaming-local.dart';

import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
//import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blurred-container-full.dart';

class DownloadComponent extends StatefulWidget {
  @override
  _DownloadComponentState createState() => _DownloadComponentState();
}

class _DownloadComponentState extends State<DownloadComponent> {
  String _downloadDirectory;
  bool _permissionReady;
  bool _isLoading;

  List<OurDownloadTask> ourDownloadTaskList = [];
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();
    initialize();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }
  void initialize()async{
    _listDownloadTask();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }


  void _bindBackgroundIsolate() {
    print("_vindBackgroundIsolate");
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      print("bind background isolate not success");
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    print("now bind background isolate success");
    print(isSuccess);
    _port.listen((dynamic data) {
      print("_port.listen -> incoming data");
      print(data);
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print("incoming info : $id, $progress, ${status.toString()}");
      /* ဒါမျိုး လုပ်ရင် သူက နဂို ယူတဲ့ data ကိုရော သွားပြင်ပေးလို့လား? */
      int downloadTaskCount = 1;
      ourDownloadTaskList.forEach((element) {
        print("download task $downloadTaskCount");
        downloadTaskCount++;
        print("task info : ${element.taskId} | ${element.progress} | ${element.status}");
        if(element.taskId == id){
          element.progress = progress;
          element.status = status;
        }
      });

      setState(() {});
      /*
      var task = ourDownloadTaskList?.where((element) => element.taskId == id);
      print("this is for specific task task.length "+task?.length.toString());
      task?.forEach((element) {
        print("task is ");
        print("taskId => "+element.taskId);
        print("progress => "+progress.toString());
        print("taskId => "+status.toString());
        element.progress = progress;
        element.status = status;
        setState(() {});
      });

       */


    });
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _unbindBackgroundIsolate() {
    print("_unbindBackgroundIsolate");
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }
  @override
  Widget build(BuildContext context) {
    return (ourDownloadTaskList.length == 0 ) ?
        Center(child: Text('No Downloaded file'),)
      :
      Column(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(ourDownloadTaskList.length, (index) {
                return _downloadCard(ourDownloadTaskList[index]);
                //return MovieCardGeneral(VideoModel.fromJson({}));
              }),
            ),
          ),
          SizedBox(height: 100,)
        ],
      );
  }


  Widget _downloadCard(OurDownloadTask ourDownloadTask){
    return InkWell(
      onTap: (){
        _openAlertDialog(ourDownloadTask);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
        ),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: Row(
            children: [
              Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image.asset('assets/images/app_icon.jpg'),
                    CachedNetworkImage(
                        width: 100,
                        imageUrl: ourDownloadTask?.videoModel?.poster_portrait ?? "https://imgbb.com/blah",
                        placeholder: (context, str) => CircularProgressIndicator(),
                        errorWidget: (context, err, er) => CircularProgressIndicator(),
                        fit: BoxFit.cover,
                    )
                  ]
              ),
              Expanded(child: Column(
                children: [
                  Expanded(child: Center(child: Text(ourDownloadTask.videoModel?.name ?? "movieName.mp4"),)),

                  (ourDownloadTask.progress == -1) ? Container() : Center(child: Text('Download : ${ourDownloadTask.progress} %'),),

                  (ourDownloadTask.progress == 100) ? Text("Complete") : Container(),
                  (ourDownloadTask.progress != 100 && ourDownloadTask.status == DownloadTaskStatus.failed) ? Text("Download fail, try again") :
                  LinearProgressIndicator(
                    value: ourDownloadTask.progress / 100,
                  ),
                  (ourDownloadTask.status == DownloadTaskStatus.failed) ? Container() :
                  (ourDownloadTask.progress == 100) ? Container() : LinearProgressIndicator()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  void _listDownloadTask()async{
    setState(() {
      ourDownloadTaskList = [];
    });
    print('VideoDownloadRoute->listDownlaodTask');
    List<OurDownloadTask> ourDownloadTaskListN = await _listDownloadTasks();
    ourDownloadTaskListN?.forEach((element) {
      print('ourDownloadTaskList');
      print('${element.name} , ${element.status.toString()}');
    });

    setState(() {
      ourDownloadTaskList = ourDownloadTaskListN;
    });
  }


  /*
  Future<String> _findLocalPath() async {
    final directory = Theme.of(context).platform == TargetPlatform.android
    //? await getExternalStorageDirectory()
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    print('directory ${directory.path}');

    // var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);

    print('directory download path ${directory.path}');
    return directory.path;
  }


  void downloadFile(String url) async{

    try{
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
      );
    }catch(exp){
      print('FlutterDownloader already initialized exp ${exp.toString()}');

    }
    // _downloadDirectory = (await _findLocalPath()) + Platform.pathSeparator + 'iMovie';
    _downloadDirectory = (await _findLocalPath()) + 'iMovie';

    final savedDir = Directory(_downloadDirectory);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }


    final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: _downloadDirectory,
        showNotification: true,
        openFileFromNotification: true);

    print('FlutterDownloader->taskId ${taskId}');
  }

   */


  void _requestDownload(OurDownloadTask task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.url,
        savedDir: _downloadDirectory,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(OurDownloadTask task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(OurDownloadTask task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
    downloadCallback(task.taskId, DownloadTaskStatus.paused, task.progress);
  }

  void _resumeDownload(OurDownloadTask task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void _retryDownload(OurDownloadTask task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
    // task.videoModel.description = newTaskId;
    await addToDownloadList(newTaskId, task.videoModel);
    _listDownloadTask();
  }

  Future<void> addToDownloadList(String taskId, VideoModel vModel) async {
    print("addToDownloadList with taskId $taskId ");
    print(vModel.name);
    //List<dynamic> data = await checkFav(videoModel);
    vModel.description = taskId;
    print(vModel.description);


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String downloadString = prefs.getString('download') ?? '[]';
    print("downloadString is ");
    print(downloadString);
    List<dynamic> downloadList = jsonDecode(downloadString);
    downloadList.add(vModel.toJson());
    await prefs.setString('download', jsonEncode(downloadList));
  }
  Future<bool> _openDownloadedFile(OurDownloadTask task) async{
    print("_openDownlaodedFile for taskId "+task.taskId);
    // get local uri

    try{
      Directory savedDir = await getExternalStorageDirectory();
      List<DownloadTask> tasks = await FlutterDownloader.loadTasksWithRawQuery(query: "SELECT * FROM task");// WHERE task_id="+task.taskId);
      print("tasks.length");
      print(tasks.length);
      if(tasks != null){
        tasks.forEach((element) {
          print("taskId : "+element.taskId);
          print("status : "+element.status.toString());
          if(element.taskId == task.taskId){
            String path = savedDir.path+"/"+element.filename;
            Provider.of<VideoProvider>(context, listen: false).setLocalVideoPath(path);
            Navigator.pushNamed(context, VideoStreamingLocalRoute.routeName);
            return true;
          }
        });
      }
      else{
        return false;
      }

    }
    catch(exp){
      print("_openDownloadedFile exp");
      print(exp);
      return false;
    }

    /*
    FlutterDownloader.open(taskId: task.taskId);
    try{
      return FlutterDownloader.open(taskId: task.taskId);
    }
    catch(exp){
      print("_openDownlaodedFile exp");
      print(exp);
      return  Future.delayed(Duration.zero, () => false); // false;
    }

     */
  }

  void _delete(OurDownloadTask task) async {
    // remove in real
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    // remove in storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String downloadString = prefs.getString('download') ?? '[]';
    print("downloadString");
    print(downloadString);
    List<dynamic> downloadList = jsonDecode(downloadString);
    int index = 0;
    int deleteId = 0;
    downloadList.forEach((element) {
      VideoModel videoModel = VideoModel.fromJson(element);
      print("videoModel.description "+videoModel.description);
      print("task.taskId "+task.taskId);
      deleteId = int.parse(index.toString()) ;
      index++;
      // if(videoModel.description == task.taskId) ourDownloadTask.videoModel = videoModel;
    });
    downloadList.removeAt(deleteId);

    await prefs.setString('download', jsonEncode(downloadList));
    ourDownloadTaskList = await _listDownloadTasks();
    setState(() {});

  }

  Future<List<OurDownloadTask>> _listDownloadTasks() async {

    /*
    try{
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
      );
    }catch(exp){
      print('FlutterDownloader already initialized exp ${exp.toString()}');

    }

     */

    final tasks = await FlutterDownloader.loadTasks();
    print('VideoDownloadRoute->tasks ${tasks.length}');
    List<OurDownloadTask> ourDownloadTaskList = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String downloadString = prefs.getString('download') ?? '[]';
    print("downloadString");
    print(downloadString);
    List<dynamic> downloadList = jsonDecode(downloadString);

    tasks?.forEach((task) {
      print('VideoDownloadRoute->tasks ${task.filename} ${task.status} ${task.progress}');
      OurDownloadTask ourDownloadTask = OurDownloadTask('','');
      ourDownloadTask.name = task.filename;
      ourDownloadTask.taskId = task.taskId;
      ourDownloadTask.status = task.status;
      ourDownloadTask.progress = task.progress;
      downloadList.forEach((element) {
        try{
          VideoModel videoModel = VideoModel.fromJson(element);
          print("videoModel.description | taskID =>  "+videoModel.description+ " | "+ task.taskId);
          if(videoModel.description == task.taskId) ourDownloadTask.videoModel = videoModel;
        }
        catch(exp){
          print("videoModel serialization fail in download-componet");
          print(element);
        }

      });
      //ourDownloadTask.videoModel = // we can get from localStorage Index :P
      ourDownloadTaskList.add(ourDownloadTask);
    });


    /*
    _permissionReady = await _checkPermission();

    _downloadDirectory = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_downloadDirectory);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });

     */

    return ourDownloadTaskList;
  }

  Future<bool> _checkPermission() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }


  Widget _downloadMenuItem(OurDownloadTask ourDownloadTask,IconData icon,String label,Function callBackFunction){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlurredContainerFull(
        child: ListTile(
          title: Text(label),
          trailing: Icon(icon,color: Colors.white,),
          onTap: (){
            Navigator.of(context).pop();
            callBackFunction(ourDownloadTask);
          },
        ),
      ),
    );
  }

  List<dynamic> _whatFunc(OurDownloadTask task){
    Function func;
    String str;
    /*
    if (task.status == DownloadTaskStatus.undefined) {
      func = _requestDownload;
      str = 'Download';
    } else
    */
    if (task.status == DownloadTaskStatus.running) {
      func = _pauseDownload;
      str = 'Pause Download';
    } else if (task.status == DownloadTaskStatus.paused) {
      func = _resumeDownload;
      str = 'Resume Download';
    } else if (task.status == DownloadTaskStatus.complete) {
      func = _delete;
      str = 'Delete Download';
    } else if (task.status == DownloadTaskStatus.failed) {
      func = _retryDownload;
      str = 'Retry Download';
    } else{
      func = _cancelDownload;
      str = 'Cancel Download';
    }

    var data = [str, func];
    return data;
  }
  Future<void> _openAlertDialog(OurDownloadTask ourDownloadTask){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        return BlurredContainerFull(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            title: Text(ourDownloadTask.name),
            content: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1,
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  _downloadMenuItem(ourDownloadTask, Icons.reset_tv,_whatFunc(ourDownloadTask)[0], _whatFunc(ourDownloadTask)[1]),
                  _downloadMenuItem(ourDownloadTask, Icons.play_arrow,'Play', _openDownloadedFile),
                  _downloadMenuItem(ourDownloadTask, Icons.cancel,'Cancel Download', _cancelDownload),
                  _downloadMenuItem(ourDownloadTask, Icons.delete,'Delete Download', _delete),

                ],

              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('အိုကေ'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
