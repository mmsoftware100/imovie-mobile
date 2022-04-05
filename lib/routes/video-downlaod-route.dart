import 'dart:convert';
import 'dart:math';
//import 'dart:math';

//import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imovie/components/download-component.dart';
import 'package:imovie/model/our-downalod-task.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
//import 'dart:isolate';
//import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
//import 'package:ext_storage/ext_storage.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoDownloadRoute extends StatefulWidget {
  static const String routeName = '/video-download-route';
  @override
  _VideoDownloadRouteState createState() => _VideoDownloadRouteState();
}

class _VideoDownloadRouteState extends State<VideoDownloadRoute> {
  String _downloadDirectory;
  bool _permissionReady;
  bool _isLoading;
  Future<String> fileDownloadUrl;
  @override
  void initState() {
    super.initState();
    // WidgetsFlutterBinding.ensureInitialized();
    //initialize();
    fileDownloadUrl = Provider.of<VideoProvider>(context,listen: false).requestFileDownloadUrl(Provider.of<VideoProvider>(context, listen: false).detailFileModel);
    initialize(); // ဒါကို ဘာလို့ မေ့နေတာလဲ မသိ
  }

  void initialize()async{
    /*
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );

     */
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
              child: _futureBuilder()
          ),
        ),
      ),
    );
  }

  Widget _futureBuilder(){
    return FutureBuilder(
        future: fileDownloadUrl,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data == null) {
              return Container(child: Center(child: Text('File streaming link unavailable!')),);
            }
            downloadFile(snapshot.data);



            /*
            try{
              _launchURL(snapshot.data);
            }catch(exp){
              return Container(child: Center(child: Text('File can not download!')),);
            }

             */




            //return DownloadComponent();
            return Container(child: Center(child: Text('File Downloaded. See in notification bar.')),);
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );
  }

  Future<String> _findLocalPath() async {

    /*
    final directory = Theme.of(context).platform == TargetPlatform.android
    //? await getExternalStorageDirectory()
        ? await getExternalStorageDirectory()
        : await getExternalStorageDirectory();

     */
    final directory = await getExternalStorageDirectories();
    directory.forEach((element) {
      print("path ");
      print(element.path);
    });
    print('video-download-route directory ${directory.last.path}');
    //var path = await getExternalStorageDirectory();
    //var path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);

    return directory.last.path;
  }
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';


  void downloadFile(String url) async{

    print('downloadFile');
    print(url);
    /*
    try{
      print('FlutterDownloader.initialize');
      await FlutterDownloader.initialize(
          debug: true // optional: set false to disable printing logs to console
      );
    }catch(exp){
      print('FlutterDownloader already initialized exp ${exp.toString()}');
    }

     */
    //_downloadDirectory = (await _findLocalPath()) + Platform.pathSeparator + 'zMovie';
    //_downloadDirectory = (await _findLocalPath());//   + 'zMovie';

    //final savedDir = Directory(_downloadDirectory);


    Directory savedDir = await getExternalStorageDirectory();
    /*
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      savedDir = await DownloadsPathProvider.downloadsDirectory;
      print("downloadsDirectory");
      print(savedDir.path);
    } on PlatformException {
      print('Could not get the downloads directory');
      savedDir = await getExternalStorageDirectory();
    }

     */
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      print("directory does not existed, so we created $savedDir");
      savedDir.create();
    }

    print("savedDir is ");
    print(savedDir.path);


    //final Random random = new Random();
    //final int randomNumber = random.nextInt(1000000);
    //final String movieName = randomNumber.toString()+"movie.mp4";

    final String name = Provider.of<VideoProvider>(context, listen: false).detailFileModel.name;
    Random rand = Random();
    final String movieName = rand.nextInt(1000000000).toString()+"_"+ name.split('/').last;

    final taskId = await FlutterDownloader.enqueue(
        //fileName: Provider.of<VideoProvider>(context, listen: false).detailFileModel.name+'.mp4',
        fileName: movieName,
        //fileName: Provider.of<VideoProvider>(context, listen: false).detailFileModel.name+'.mp4',
        //url: 'http://ipv4.download.thinkbroadband.com/100MB.zip',
        url: url,
        savedDir: savedDir.path,
        showNotification: true,
        openFileFromNotification: false
    );
    await addToDownloadList(taskId);
    // store with taskId - VideoModel in localStorage

    print('FlutterDownloader->taskId ${taskId}');
  }


  Future<void> addToDownloadList(String taskId) async {
    print("addToDownloadList with taskId $taskId");
    //List<dynamic> data = await checkFav(videoModel);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String downloadString = prefs.getString('download') ?? '[]';
    print("downloadString is ");
    print(downloadString);

    List<dynamic> downloadList = jsonDecode(downloadString);
    downloadList.forEach((element) {
      print("downloadList element");
      print(element);
      VideoModel vM = VideoModel.fromJson(element);
      print(vM.name);
    });
    VideoModel videoModel = Provider.of<VideoProvider>(context,listen: false).detailVideoModel;
    print("videoModel detail's name is ");
    print(videoModel.name);
    print(videoModel.description);
    videoModel.description = taskId;
    print(videoModel.description);
    downloadList.add(videoModel.toJson());
    await prefs.setString('download', jsonEncode(downloadList));
  }

}
