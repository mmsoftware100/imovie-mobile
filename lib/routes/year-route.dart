import 'package:flutter/material.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/components/thumb-tile-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';

class YearRoute extends StatefulWidget {
  static const String routeName = '/year-route';
  @override
  _YearRouteState createState() => _YearRouteState();
}

class _YearRouteState extends State<YearRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<VideoProvider>(context,listen: true).detailYear.toString()),
      ),
      body: _futureBuilder(),
    );
  }

  Widget _futureBuilder(){
    return FutureBuilder(
      future: Provider.of<VideoProvider>(context,listen: true).videoModelListYear,
      builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
        if (snapshot.hasData) {
          return _mainGrid(snapshot.data);
        }else if (snapshot.hasError) {
          return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
        }
        else{
          return Container(child: Center(child: Text('loading...')),);
        }
      },
    );
  }

  Widget _mainList(List<VideoModel> videoList){
    if(videoList.length == 0 ) return Container(child: Center(child: Text('loading...')),);
    return ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(videoList.length, (index) {
          return MovieCardGeneral(videoList[index]);
        })
    );
  }


  Widget _mainGrid(List<VideoModel> videoList){
    if(videoList.length == 0 ) return Container(child: Center(child: Text('loading...')),);
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1/1.5,
      children: List.generate(videoList.length, (index) {
        return ThumbTileComponent(videoList[index]);
      }),
    );

  }


}
