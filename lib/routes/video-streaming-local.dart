import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
class VideoStreamingLocalRoute extends StatefulWidget {
  static const String routeName = '/VideoStreamingLocalRoute';
  @override
  _VideoStreamingLocalRouteState createState() => _VideoStreamingLocalRouteState();
}

class _VideoStreamingLocalRouteState extends State<VideoStreamingLocalRoute> {
  BetterPlayerController _betterPlayerController;



  @override
  void initState() {
    super.initState();
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

  Future<String> _getVideoUrl(){
    // get internal uri for specific file
    return Future.delayed(Duration.zero,(){
      return Provider.of<VideoProvider>(context, listen: false).localVideoPath;
    });
  }
  Widget _futureBuilder(){
    return FutureBuilder(
        future: _getVideoUrl(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data == null){
              return Container(child: Center(child: Text('File streaming link unavailable!')),);
            }

            BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
                BetterPlayerDataSourceType.file,
                snapshot.data
            );
            /*
            BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
                BetterPlayerDataSourceType.network,
                snapshot.data
            );

             */
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
