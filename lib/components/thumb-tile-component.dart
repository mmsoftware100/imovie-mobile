import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/video-detail-route.dart';
import 'package:provider/provider.dart';

class ThumbTileComponent extends StatelessWidget {
  VideoModel videoModel;

  ThumbTileComponent(this.videoModel);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: GestureDetector(
          child: Stack(
            children: [
              Container(
                width: 150,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: videoModel.poster_portrait,
                    placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Center(child: CircularProgressIndicator(),),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 20,
                  color: Colors.red,
                  width: 150,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                  child: Center(child: Text(videoModel.name.substring(0, videoModel.name.length > 20 ? 20 : videoModel.name.length ))),
                ),
              )
            ],
          ),
          onTap: () {
            Provider.of<VideoProvider>(context, listen: false)
                .setVideoDetail(videoModel);
            Navigator.pushNamed(context, VideoDetailRoute.routeName);
          }),
    );
  }

/*
  old

    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.0),
            //height: screenWidth / 3,
            //width: screenWidth / 4.25,
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/poster_portraits/1.jpg'), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            //height: screenWidth / 3,
            //width: screenWidth / 4.25,
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(videoModel.poster_portrait), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
      onTap: () {
        Provider.of<VideoProvider>(context, listen: false).setVideoDetail(videoModel);
        Navigator.pushNamed(context, VideoDetailRoute.routeName);
      }
    );

   */
}
