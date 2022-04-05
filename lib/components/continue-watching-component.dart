
import 'package:flutter/material.dart';
import 'package:imovie/components/continue-watching-card-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';

class ContinueWatchingComponent extends StatefulWidget {
  @override
  _ContinueWatchingComponentState createState() => _ContinueWatchingComponentState();
}

class _ContinueWatchingComponentState extends State<ContinueWatchingComponent> {
  @override
  Widget build(BuildContext context) {
    return _listView();
  }
  Widget _listView(){
    return FutureBuilder(
      future: Provider.of<VideoProvider>(context, listen: true).videoModelListFeatured,//Provider.of<VideoProvider>(context, listen: true).requestVideoModelListFeatured(),
        builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
          if (snapshot.hasData) {
            // we need to reverse this list
            return _mainContainer(snapshot.data);
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );
  }
  Widget _mainContainer(List<VideoModel> videoList){
    return Container(
      margin: EdgeInsets.only(left: 8.0),
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: videoList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ContinueWatchingCardComponent(videoList[index]);
        },
      ),
    );
  }
}

