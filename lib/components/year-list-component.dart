import 'dart:math';

import 'package:flutter/material.dart';
import 'package:imovie/model/year-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/year-route.dart';
import 'package:provider/provider.dart';

class YearListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 4;
    List<YearModel> years = [];
    List colors = [Colors.red, Colors.green,Colors.orange, Colors.grey, Colors.blue];
    final Random random = new Random();
    for(int i = 2022; i > 1969; i--){
      ///print('year is $i');
      years.add(YearModel(i, colors[random.nextInt(colors.length - 1)] ));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: years.length,
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Provider.of<VideoProvider>(context,listen: false).setYearDetail(years[index].year);
            Navigator.pushNamed(context, YearRoute.routeName);
            //=> Navigator.pushNamed(context, PageRoutes.movieDetailsPage
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: years[index].color,
            ),
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Text(
                  years[index].year.toString(),
                  style: Theme.of(context).textTheme.caption,
                )),
          ),
        );
      },
    );
  }
}
