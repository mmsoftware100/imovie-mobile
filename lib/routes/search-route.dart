import 'package:flutter/material.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/components/thumb-tile-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';

class SearchRoute extends StatefulWidget {
  static const routeName = '/search-route';
  @override
  _SearchRouteState createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _mainSearchPanel(),
      ),
    );
  }

  Widget _mainSearchPanel(){
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      //mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _searchTitle(),
        _searchInput(),
        Expanded(child: _searchResult())
      ],
    );
  }

  Widget _searchTitle(){
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Search Title',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(letterSpacing: 1.2),
      ),
    );
  }

  Widget _searchInput(){
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 24.0),
      color: Colors.transparent,
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: mainColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: 'ရှာဖွေရန်',
          labelStyle: TextStyle(color: Colors.white),
          hintText: 'Crash landing on You',
          hintStyle: TextStyle(color: unselectedLabelColor),
        ),
        onSubmitted: (String searchKeyword) {
          print('SearchRoute->searchInput submited');
          print(searchKeyword);
          if(searchKeyword == '') return;
          Provider.of<VideoProvider>(context, listen: false).requestVideoModelListSearch(searchKeyword);
        },
      ),
    );
  }

  Widget _searchResult(){
    return Container(
      child: Center(
        child: _movieList(),
      ),
    );
  }

  Widget _movieList(){

    return FutureBuilder(
      future: Provider.of<VideoProvider>(context, listen: true).videoModelListSearch,
        builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
          if (snapshot.hasData) {
            return _listView(snapshot.data);
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );

  }

  Widget _listView(List<VideoModel> videoList){
    if(videoList.length == 0 ) return Container(child: Center(child: Text('loading...')),);
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1/1.5,
      children: List.generate(videoList.length, (index) {
        return ThumbTileComponent(videoList[index]);
      }),
    );
    /*
    if(videoList.length == 0 ) return Container(child: Center(child: Text('loading...')),);
    return ListView(
      children: List.generate(videoList.length, (index) {
        return MovieCardGeneral(videoList[index]);
      }),
    );

     */
  }

}
