import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:imovie/components/main-component.dart';
import 'package:imovie/model/video-model.dart';

class OurDownloadTask{
  String name;
  String url;

  String taskId;
  String h;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;
  VideoModel videoModel;

  OurDownloadTask(this.name, this.url);
}