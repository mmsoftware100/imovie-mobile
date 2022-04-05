/*
this route display video ads before actual video is displayed
request api and display video
and then replaced route with actual video url
if not go back to video detail route.

1. request ads via api call in init state or get via Provider or may be static ads url
2. play video
3. after video is finished or user press skip (FAB) replaced route with detail video.
Navigator.pushNamed(context, VideoStreamingRoute.routeName);
 */

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imovie/data/const-data.dart';
import 'package:imovie/routes/video-streaming-route.dart';

class FullVideoAdsRoute extends StatefulWidget {
  static const String routeName = '/full-video-ads-route';
  @override
  _FullVideoAdsRouteState createState() => _FullVideoAdsRouteState();
}

class _FullVideoAdsRouteState extends State<FullVideoAdsRoute> {
  BetterPlayerController _betterPlayerController;

  String url = 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

  @override
  void initState() {
    super.initState();
    /*
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

     */
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: false,
          fullScreenByDefault: false,
        )
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    /*
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        fullVideoAdsUrl
    );
    _betterPlayerController.setupDataSource(betterPlayerDataSource);
    return Scaffold(body: _viderPlayer());
  }

  Widget _viderPlayer(){
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          child: BetterPlayer(
            controller: _betterPlayerController,
          ),
        ),
        /*
        AspectRatio(
          aspectRatio: _betterPlayerController.getAspectRatio(),
          //aspectRatio: 16 / 9,
          child: BetterPlayer(

            controller: _betterPlayerController,
          ),
        ),

         */
        Text('your video will play after this ads finished', style: TextStyle(color: Colors.white, fontSize: 14),),
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.pushReplacementNamed(context, VideoStreamingRoute.routeName);
            },
            child: Icon(Icons.skip_next),
          ),
        )
      ],
    );
  }
}
