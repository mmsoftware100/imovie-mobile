import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
class VideoStreamingRoute extends StatefulWidget {
  static const String routeName = '/video-streaming-route';
  @override
  _VideoStreamingRouteState createState() => _VideoStreamingRouteState();
}

class _VideoStreamingRouteState extends State<VideoStreamingRoute> {
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
          looping: true,
          fullScreenByDefault: false,
        )
    );
  }


  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: _futureBuilder()
          ),
        ),
      ),
    );
  }

  Widget _futureBuilder(){
    return FutureBuilder(
      future: Provider.of<VideoProvider>(context,listen: false).requestFileDownloadUrl(Provider.of<VideoProvider>(context, listen: false).detailFileModel),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data == null){
              return Container(child: Center(child: Text('File streaming link unavailable!')),);
            }
            BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                snapshot.data
            );
            _betterPlayerController.setupDataSource(betterPlayerDataSource);
            return _viderPlayer();
          }else if (snapshot.hasError) {
            return Container(child: Center(child: Text('error ${snapshot.error.toString()}')),);
          }
          else{
            return Container(child: Center(child: Text('loading...')),);
          }
        }
    );
  }
  Widget _viderPlayer(){
    return Container(
      //aspectRatio: 16 / 9,
      height: MediaQuery.of(context).size.height,
      child: BetterPlayer(

        controller: _betterPlayerController,
      ),
    );
  }
}
