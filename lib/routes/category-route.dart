import 'package:flutter/material.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/components/thumb-tile-component.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryRoute extends StatefulWidget {
  static const String routeName = '/category-route';
  @override
  _CategoryRouteState createState() => _CategoryRouteState();
}

class _CategoryRouteState extends State<CategoryRoute> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<VideoProvider>(context,listen: true).detailCategoryModel.name),
      ),
      body: _futureBuilder(),
    );
  }

  Widget _futureBuilder(){
    return FutureBuilder(
      future: Provider.of<VideoProvider>(context,listen: true).videoModelListCategory,
      builder: (BuildContext context, AsyncSnapshot<List<VideoModel>> snapshot) {
        if (snapshot.hasData) {
          return _mainList(snapshot.data);
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
    return SmartRefresher(
      //enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: () async{
          print("onRefresh");
          _dataRefresh();
          return Future.delayed(Duration(milliseconds: 10000), () {
            print("refreshCompleted");
            _refreshController.refreshCompleted();
          });
        },
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1/1.5,
          children: List.generate(videoList.length, (index) {
            return ThumbTileComponent(videoList[index]);
          }),
        )
    );
    return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1/1.5,
        children: List.generate(videoList.length, (index) {
          return ThumbTileComponent(videoList[index]);
        }),
    );
    return ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(videoList.length, (index) {
          return MovieCardGeneral(videoList[index]);
        })
    );
  }


  void _dataRefresh(){
    // request set detail and request provider method
    // requestVideoModelListCategory
    int categoryId = Provider.of<VideoProvider>(context,listen: false).detailCategoryModel.id;
    Provider.of<VideoProvider>(context,listen: false).requestVideoModelListCategory(categoryId);
  }
  Widget _pullToRefresh() {
    return SmartRefresher(
      //enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: () async{
          print("onRefresh");
          _dataRefresh();
          return Future.delayed(Duration(milliseconds: 10000), () {
            print("refreshCompleted");
            _refreshController.refreshCompleted();
          });
        },
        child: _futureBuilder()
    );
  }

}

/*
odl
return ListView(
        physics: BouncingScrollPhysics(),
        children: List.generate(videoList.length, (index) {
          return MovieCardGeneral(videoList[index]);
        })
    );

 */
