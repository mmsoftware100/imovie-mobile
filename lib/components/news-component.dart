import 'package:flutter/material.dart';
import 'package:imovie/components/movie-card-general.dart';
import 'package:imovie/model/video-model.dart';

class NewsComponent extends StatefulWidget {
  @override
  _NewsComponentState createState() => _NewsComponentState();
}

class _NewsComponentState extends State<NewsComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(10, (index) {
        return MovieCardGeneral(VideoModel.fromJson({}));
      }),
    );
  }
}
