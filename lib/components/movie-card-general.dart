import 'package:flutter/material.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-detail-route.dart';
import 'package:provider/provider.dart';

class MovieCardGeneral extends StatelessWidget {
  final VideoModel videoModel;
  MovieCardGeneral(this.videoModel);
  @override
  Widget build(BuildContext context) {
    return _movieCard(videoModel,context);
  }

  Widget _movieCard(VideoModel videoModel,BuildContext context){
    return InkWell(
      onTap: (){
        Provider.of<VideoProvider>(context, listen: false).setVideoDetail(videoModel);
        Navigator.pushNamed(context, VideoDetailRoute.routeName);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8)
        ),
        child: AspectRatio(
          aspectRatio: 2.5,
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                  children: [
                    Image.asset('assets/images/poster_portraits/1.jpg'),
                    CircularProgressIndicator(),
                    Image.network(videoModel.poster_portrait)
                  ]
              ),
              Expanded(child: Center(child: Text(videoModel.name),))
            ],
          ),
        ),
      ),
    );
  }
}
