
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imovie/model/category-model.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/category-route.dart';
import 'package:provider/provider.dart';

class CategoryListComponent extends StatefulWidget {
  @override
  _CategoryListComponentState createState() => _CategoryListComponentState();
}

class _CategoryListComponentState extends State<CategoryListComponent> {
  @override
  Widget build(BuildContext context) {
    return _mainList();
  }

  Widget _mainList(){
    return FutureBuilder(
      future: Provider.of<VideoProvider>(context, listen: true).categoryModelList,
        builder: (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
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

  Widget _listView(List<CategoryModel> categoryList){
    final width = MediaQuery.of(context).size.width / 3;
    List<MaterialColor> colors = [Colors.red, Colors.blue, Colors.green];
    final Random rand = Random();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: categoryList.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<VideoProvider>(context, listen: false).setCategoryDetail(categoryList[index]);
            Navigator.pushNamed(context, CategoryRoute.routeName);
            //=> Navigator.pushNamed(context, PageRoutes.movieDetailsPage
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: colors[rand.nextInt(colors.length - 1)],
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  categoryList[index].name,
                  style: Theme.of(context).textTheme.caption,
                )),
          ),
        );
      },
    );
  }
}

