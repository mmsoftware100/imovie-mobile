import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/components/thumb-tile-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteComponent extends StatefulWidget {
  @override
  _FavoriteComponentState createState() => _FavoriteComponentState();
}

class _FavoriteComponentState extends State<FavoriteComponent> {

  SharedPreferences prefs ;
  List<VideoModel> videoModelList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }
  void initialize()async {
    prefs = await SharedPreferences.getInstance();
    String favString = prefs?.getString('favorite') ?? '[]';
    print('MainRoute->favString');
    print(favString);
    List<dynamic> data = jsonDecode(favString);
    data = data.reversed.toList();
    data.forEach((element) {
      videoModelList.add(VideoModel.fromJson(element));
    });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return _favGrid();

  }

  Widget _favList() {

    return ListView.separated(
      itemCount: videoModelList.length,
      itemBuilder: (context, index){
        return MovieCardGeneral(videoModelList[index]);
      },
      separatorBuilder: (context, index){
        return Divider();
      },
    );

  }

  Widget _favGrid() {

    if(videoModelList.length == 0 ) return Container(child: Center(child: Text('loading...')),);
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1/1.5,
      children: List.generate(videoModelList.length, (index) {
        return ThumbTileComponent(videoModelList[index]);
      }),
    );

  }

}
