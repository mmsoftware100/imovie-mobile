import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imovie/components/blurred-container-full.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/components/video-detail-component.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-streaming-route.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';


class VideoDetailRoute extends StatelessWidget {
  static const String routeName = '/video-detail-route';
  final String title = 'title';
  final String genre = 'genre';

  VideoDetailRoute();

  @override
  Widget build(BuildContext context) {
    final movieModel = Provider.of<VideoProvider>(context, listen: false).detailVideoModel;
    print('VideoDetailRoute->movieModel');
    print(movieModel.toJson());
    return VideoDetailComponent(movieModel);
    //return MovieDetailsBody(title, genre);
  }
}

