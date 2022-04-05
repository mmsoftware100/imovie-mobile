import 'package:flutter/material.dart';
import 'package:imovie/components/thumb-tile-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:imovie/model/video-model.dart';

class VideoListHorizontalComponent extends StatefulWidget {

  VideoListHorizontalComponent(this.videoModelListLatestUpdate);
  final Future<List<VideoModel>> videoModelListLatestUpdate;
  @override
  _VideoListHorizontalComponentState createState() => _VideoListHorizontalComponentState();
}

class _VideoListHorizontalComponentState extends State<VideoListHorizontalComponent> {
  @override
  Widget build(BuildContext context) {
    return _futureBuilder();
  }

  Widget _futureBuilder(){
    return FutureBuilder(
      future: widget.videoModelListLatestUpdate,//Provider.of<VideoProvider>(context, listen: true).featuredVideoModelList,//Provider.of<VideoProvider>(context, listen: true).requestVideoModelListFeatured(),
        builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
          if (snapshot.hasData) {
            return _horizon(snapshot.data);
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );
  }
  Widget _horizon(List<VideoModel> videoList){
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      //height: screenWidth / 3,
      //height: MediaQuery.of(context).size.height / 5,
      height: 250,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: videoList.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ThumbTileComponent(videoList[index]);
          }),
    );
  }
}
