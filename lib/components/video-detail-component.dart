import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:imovie/components/blurred-container-full.dart';
import 'package:imovie/components/blurred-container-update.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/core/time_converter.dart';
import 'package:imovie/data/AdHelper.dart';
import 'package:imovie/data/const-data.dart';
import 'package:imovie/model/episode-model.dart';
import 'package:imovie/model/file-model.dart';
import 'package:imovie/model/resolution-model.dart';
import 'package:imovie/model/season-model.dart';
import 'package:imovie/model/user-model.dart';
import 'package:imovie/model/video-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/ads_route.dart';
import 'package:imovie/routes/premium-user-route.dart';
import 'package:imovie/routes/reward-page.dart';
import 'package:imovie/routes/video-downlaod-route.dart';
import 'package:imovie/routes/video-streaming-route.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoDetailComponent extends StatefulWidget {
  final VideoModel videoModel;

  VideoDetailComponent(this.videoModel);

  @override
  _VideoDetailComponentState createState() => _VideoDetailComponentState();
}

class _VideoDetailComponentState extends State<VideoDetailComponent> {
  bool favorite = false;
  /*

  InterstitialAd _interstitialAd;

   */

  bool premiumContent = false;
  bool premiumUser = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




    initialize();
  }

  void initialize() async {
    List<dynamic> data = await checkFav(widget.videoModel);
    setState(() {
      favorite = data[0];
    });

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('favorite','[]');
    widget.videoModel.category.forEach((element) {
      if(element.id == 1 ) premiumContent = true;
    });

    print("vidoe-detail-component premium");
    print(premiumContent);

    UserModel userModel = Provider.of<VideoProvider>(context, listen: false).userModel;
    print('userModel is premium?');
    print(userModel);
    if(userModel != null ){
      premiumUser = true;
    }
    if(!premiumContent){
      print("video-detail-component , premium is not true, so load interstitial ad");
      // load interstitial ad
      /*
      InterstitialAd.load(
          adUnitId: AdHelper.interstitialAdUnitId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              print("InterstitialAd loaded");
              this._interstitialAd = ad;
              _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (InterstitialAd ad) =>
                    print('$ad onAdShowedFullScreenContent.'),
                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                  print('$ad onAdDismissedFullScreenContent.');
                  ad.dispose();
                },
                onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                  print('$ad onAdFailedToShowFullScreenContent: $error');
                  ad.dispose();
                },
                onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
              );
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error');
            },
          )
      );

       */
    }

  }

  bool _enoughPointForWatch(int point){
    if(point >= streamCost ) return true;
    else return false;
  }
  bool _enoughPointForDownload(int point){
    if(point >= downloadCost ) return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    String categoryString = "";
    if (widget.videoModel?.category?.first?.name == null)
      categoryString = "no category";
    else {
      widget.videoModel.category.forEach((element) {
        categoryString += element.name + " | ";
      });
    }
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[

            Container(
              height: screenHeight / 2.0,
              child: Stack(
                children: <Widget>[
                  // poster
                  Container(
                    height: screenHeight / 2.0,
                    width: double.infinity,
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [transparentColor,transparentColor, scaffoldBackgroundColor],
                        stops: [0.0, 0.7, 1.0],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                    ),
                    child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: widget.videoModel.poster_landscape,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Center(child: CircularProgressIndicator(),),
                    ),
                  ),
                  // back arrow
                  Positioned(
                    top: 20,
                    left: 0,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                      onPressed: () {
                        print('back onPressed');
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // play button white

                  (widget.videoModel.movie_type != 10)
                      ? Positioned(
                          top: screenHeight / 3.6,
                          left: screenWidth / 2.5,
                          child: BlurredContainerUpdate(
                            child: IconButton(
                              icon: Icon(Icons.play_arrow),
                              color: Colors.white,
                              onPressed: () {
                                print('play_arrow onPressed');


                                int point = Provider.of<VideoProvider>(context, listen: false).point;

                                if(_enoughPointForWatch(point) == false){
                                  // you don't have enough point to stream
                                  // so go to point and get more point
                                  notifyAndGoReward();
                                  return;
                                }

                                void callBack(FileModel fileModel) async {
                                  Provider.of<VideoProvider>(context, listen: false).setPoint(point - streamCost);
                                  // file name call back
                                  print('callBack ${fileModel.name}');
                                  // set and request detail file url

                                  //check premium content or not?
                                  // basic resolution is 1 , စစ်
                                  // step 1. premium content လား စစ်မယ်။
                                  if(!premiumUser){
                                    // route to custom video route

                                    /*
                                    try{
                                      _interstitialAd.show();
                                    }
                                    catch(exp){
                                      print("can't show _interstitialAd");
                                      print(exp);
                                    }

                                     */
                                    //Navigator.pushNamed(context, PremiumUserRoute.routeName);
                                    //return;
                                  }

                                  // fileModel.resolution.id > 1 ||
                                  if( premiumContent) {
                                    // step 2. premium user လား စစ်မယ်။
                                    if(!premiumUser){
                                      var result = await Navigator.pushNamed(context, PremiumUserRoute.routeName);
                                      if(result == null ){
                                        // Navigator.pushNamed(context, FullVideoAdsRoute.routeName);
                                      }
                                      return;
                                    }
                                  }
                                  else{
                                    dynamic result = await Navigator.pushNamed(context, VideoStreamingRoute.routeName);
                                    /*
                                    if(result == null) {
                                      InterstitialAd.load(
                                          adUnitId: AdHelper.interstitialAdUnitId,
                                          request: AdRequest(),
                                          adLoadCallback: InterstitialAdLoadCallback(
                                            onAdLoaded: (InterstitialAd ad) {
                                              // Keep a reference to the ad so you can show it later.
                                              print("InterstitialAd loaded");
                                              this._interstitialAd = ad;
                                              _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
                                                onAdShowedFullScreenContent: (InterstitialAd ad) =>
                                                    print('$ad onAdShowedFullScreenContent.'),
                                                onAdDismissedFullScreenContent: (InterstitialAd ad) {
                                                  print('$ad onAdDismissedFullScreenContent.');
                                                  ad.dispose();
                                                },
                                                onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
                                                  print('$ad onAdFailedToShowFullScreenContent: $error');
                                                  ad.dispose();
                                                },
                                                onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
                                              );
                                            },
                                            onAdFailedToLoad: (LoadAdError error) {
                                              print('InterstitialAd failed to load: $error');
                                            },
                                          )
                                      );
                                    }

                                     */
                                  }

                                }

                                openAlertDialog(
                                    'Stream',
                                    widget.videoModel.season_list.first
                                        .episode_list.first.file_model_list,
                                    callBack,
                                    Icons.video_settings_outlined);
                              },
                            ),
                          ),
                        )
                      : Container(),


                  /*
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // video name
                        Text(
                          widget.videoModel.name,
                          //style: Theme.of(context).textTheme.headline5,
                          style: TextStyle(color: Colors.white),
                        ),

                        // video data duration, category, year
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: RichText(
                            text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: unselectedLabelColor),
                              children: [
                                TextSpan(
                                    text: TimeConverter.convertToHour(
                                        minutes: widget
                                            .videoModel
                                            .season_list
                                            .first
                                            .episode_list
                                            .first
                                            .duration)),
                                TextSpan(
                                    text: '   |   ',
                                    style:
                                        TextStyle().copyWith(color: mainColor)),
                                TextSpan(text: categoryString),
                                //text: widget.videoModel?.category?.first?.name ?? ''),
                                TextSpan(
                                    text: '   |   ',
                                    style:
                                        TextStyle().copyWith(color: mainColor)),
                                TextSpan(
                                    text: widget.videoModel.release_year
                                        .toString()),
                                TextSpan(
                                    text: '   |   ',
                                    style:
                                        TextStyle().copyWith(color: mainColor)),
                                TextSpan(text: ''),
                              ],
                            ),
                          ),
                        ),

                        // Play Button Green, fav, download
                        //(widget.videoModel.video_type == 2) ? _favButton() : Container(),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              RawMaterialButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 42.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                fillColor: mainColor,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Play',
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ],
                                ),
                                onPressed: () async{
                                  print(
                                      'VideoDetailRoute->playButton onPressed');
                                  // ဒီမှာ point စစ်ပြီး မလောက်သေးလို့ ကြော်ညာ ကြည့်ဖို့ပြောမယ်

                                  int point = Provider.of<VideoProvider>(context, listen: false).point;
                                  if(_enoughPointForWatch(point)){
                                    void callBack(FileModel fileModel) {
                                      Provider.of<VideoProvider>(context, listen: false).setPoint(point - 5);
                                      /*
                                      try{
                                        _interstitialAd.show();
                                      }
                                      catch(exp){
                                        print("can't show _interstitialAd");
                                        print(exp);
                                      }

                                       */
                                      // file name call back
                                      print('callBack ${fileModel.name}');
                                      // set and request detail file url
                                      Navigator.pushNamed(
                                          context, VideoStreamingRoute.routeName);
                                    }

                                    openAlertDialog(
                                        'Stream',
                                        widget.videoModel.season_list.first
                                            .episode_list.first.file_model_list,
                                        callBack,
                                        Icons.video_settings_outlined);
                                  }
                                  else{
                                    void callBack(FileModel fileModel)async{
                                      /*
                                      try{
                                        _interstitialAd.show();
                                        int point = Provider.of<VideoProvider>(context, listen: false).point;
                                        await Provider.of<VideoProvider>(context, listen: false).setPoint(point + 5);
                                      }catch(exp){
                                        print("_interstitialAd.show exp");
                                        print(exp);
                                      }

                                       */
                                      Navigator.pushNamed(context, RewardPage.routeName);
                                    }
                                    openAlertDialog(
                                        'No Enough Point',
                                        [FileModel(0, ResolutionModel(0,"Get Point"), "name", 0)],
                                        callBack,
                                        Icons.video_settings_outlined);
                                  }

                                },
                              ),
                              Spacer(),
                              _favButton(),
                              Spacer(),
                              (Theme.of(context).platform == TargetPlatform.iOS) ? Container() :
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: Color(0xff212020),
                                child: IconButton(
                                  color: mainColor,
                                  icon: Icon(Icons.file_download),
                                  onPressed: () {
                                    int point = Provider.of<VideoProvider>(context, listen: false).point;

                                    if(_enoughPointForWatch(point) == false){
                                      // you don't have enough point to stream
                                      // so go to point and get more point
                                      notifyAndGoReward();
                                      return;
                                    }
                                    
                                    void callBack(FileModel fileModel) {
                                      Provider.of<VideoProvider>(context, listen: false).setPoint(point - streamCost);
                                      // file name call back
                                      print('callBack ${fileModel.name}');
                                      // set and request detail file url
                                      // TDL : download function
                                      Navigator.pushNamed(context,
                                          VideoDownloadRoute.routeName);
                                    }

                                    openAlertDialog(
                                        'Download',
                                        widget.videoModel.season_list.first
                                            .episode_list.first.file_model_list,
                                        callBack,
                                        Icons.file_download);
                                  },
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                   */
                  //AppBar(automaticallyImplyLeading: true),
                  //AppBar(),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // video name
                  Text(
                    widget.videoModel.name,
                    //style: Theme.of(context).textTheme.headline5,
                    style: TextStyle(color: Colors.white),
                  ),

                  // video data duration, category, year
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: unselectedLabelColor),
                        children: [
                          TextSpan(
                              text: widget
                                      .videoModel
                                      .season_list
                                      .first
                                      .episode_list
                                      .first
                                      .file_model_list.first.file_size.toString() + " Mb"),
                          TextSpan(
                              text: '   |   ',
                              style:
                              TextStyle().copyWith(color: mainColor)),
                          TextSpan(
                              text: TimeConverter.convertToHour(
                                  minutes: widget
                                      .videoModel
                                      .season_list
                                      .first
                                      .episode_list
                                      .first
                                      .duration)),
                          TextSpan(
                              text: '   |   ',
                              style:
                              TextStyle().copyWith(color: mainColor)),
                          TextSpan(text: categoryString),
                          //text: widget.videoModel?.category?.first?.name ?? ''),
                          TextSpan(
                              text: '   |   ',
                              style:
                              TextStyle().copyWith(color: mainColor)),
                          TextSpan(
                              text: widget.videoModel.release_year
                                  .toString()),
                          TextSpan(
                              text: '   |   ',
                              style:
                              TextStyle().copyWith(color: mainColor)),
                          TextSpan(text: ''),
                        ],
                      ),
                    ),
                  ),

                  // Play Button Green, fav, download
                  //(widget.videoModel.video_type == 2) ? _favButton() : Container(),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        RawMaterialButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 42.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          fillColor: mainColor,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Play',
                                style:
                                Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                          onPressed: () async{
                            print(
                                'VideoDetailRoute->playButton onPressed');
                            // ဒီမှာ point စစ်ပြီး မလောက်သေးလို့ ကြော်ညာ ကြည့်ဖို့ပြောမယ်

                            int point = Provider.of<VideoProvider>(context, listen: false).point;
                            if(_enoughPointForWatch(point)){
                              void callBack(FileModel fileModel) {
                                Provider.of<VideoProvider>(context, listen: false).setPoint(point - streamCost);
                                /*
                                      try{
                                        _interstitialAd.show();
                                      }
                                      catch(exp){
                                        print("can't show _interstitialAd");
                                        print(exp);
                                      }

                                       */
                                // file name call back
                                print('callBack ${fileModel.name}');
                                // set and request detail file url
                                Navigator.pushNamed(
                                    context, VideoStreamingRoute.routeName);
                              }

                              openAlertDialog(
                                  'Stream',
                                  widget.videoModel.season_list.first
                                      .episode_list.first.file_model_list,
                                  callBack,
                                  Icons.video_settings_outlined);
                            }
                            else{
                              void callBack(FileModel fileModel)async{
                                /*
                                      try{
                                        _interstitialAd.show();
                                        int point = Provider.of<VideoProvider>(context, listen: false).point;
                                        await Provider.of<VideoProvider>(context, listen: false).setPoint(point + 5);
                                      }catch(exp){
                                        print("_interstitialAd.show exp");
                                        print(exp);
                                      }

                                       */
                                Navigator.pushNamed(context, RewardPage.routeName);
                              }
                              openAlertDialog(
                                  'No Enough Point',
                                  [FileModel(0, ResolutionModel(0,"Get Point, Stream Cost $streamCost , Downlaod Cost $downloadCost"), "name", 0)],
                                  callBack,
                                  Icons.video_settings_outlined);
                            }

                          },
                        ),
                        Spacer(),
                        _favButton(),
                        Spacer(),
                        (Theme.of(context).platform == TargetPlatform.iOS) ? Container() :
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Color(0xff212020),
                          child: IconButton(
                            color: mainColor,
                            icon: Icon(Icons.file_download),
                            onPressed: () {
                              int point = Provider.of<VideoProvider>(context, listen: false).point;

                              if(_enoughPointForDownload(point) == false){
                                // you don't have enough point to stream
                                // so go to point and get more point
                                notifyAndGoReward();
                                return;
                              }

                              void callBack(FileModel fileModel) {
                                Provider.of<VideoProvider>(context, listen: false).setPoint(point - downloadCost);
                                // file name call back
                                print('callBack ${fileModel.name}');
                                // set and request detail file url
                                // TDL : download function
                                Navigator.pushNamed(context,
                                    VideoDownloadRoute.routeName);
                              }

                              openAlertDialog(
                                  'Download',
                                  widget.videoModel.season_list.first
                                      .episode_list.first.file_model_list,
                                  callBack,
                                  Icons.file_download);
                            },
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(height: 2),
                  children: [
                    TextSpan(
                        text: widget.videoModel.description,
                        style: TextStyle(color: lightTextColor))
                  ],
                ),
              ),
            ),

            (widget.videoModel.movie_type == 1)
                ? Container()
                : _seasonList(widget.videoModel.season_list),
            /*
            Container(
              margin: EdgeInsets.all(16),
              child: Text('Season ( ${widget.videoModel.season_list.first.description.toString()} )')
            ),
            Column(
              children: List.generate(widget.videoModel.season_list.first.episode_list.length, (index) {
                  return _downloadOptions(widget.videoModel.season_list.first.episode_list[index]);
              })
            )

             */

            // TabSection(tab1: AppLocalizations.of(context).clips),
          ],
        ),
      ),
    );
  }

  Widget _seasonList(List<SeasonModel> seasonList) {
    return Column(
      children: List.generate(seasonList.length, (seasonIndex) {
        return Column(
          children: [
            Container(
                margin: EdgeInsets.all(16),
                child: (seasonList[seasonIndex].season.name == null)
                    ? Text('Season()')
                    : Text(
                        'Season ( ${seasonList[seasonIndex].season.name} )')),
            Column(
              children: List.generate(
                  seasonList[seasonIndex].episode_list.length, (episodeIndex) {
                return _downloadOptions(
                    seasonList[seasonIndex].episode_list[episodeIndex]);
              }),
            )
          ],
        );
      }),
    );
  }

  Widget _downloadOptions(EpisodeModel episodeModel) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0),
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 42.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            fillColor: mainColor,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                SizedBox(width: 10.0),
                Text(
                  "Episode (${episodeModel.episode.name})",
                  //"${episodeModel.episode.name} : ${episodeModel.episode_description}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
            onPressed: () {
              print('VideoDetailRoute->playButton onPressed');


              int point = Provider.of<VideoProvider>(context, listen: false).point;
              if(_enoughPointForWatch(point)){
                void callBack(FileModel fileModel) {
                  Provider.of<VideoProvider>(context, listen: false).setPoint(point - streamCost);
                  /*
                                      try{
                                        _interstitialAd.show();
                                      }
                                      catch(exp){
                                        print("can't show _interstitialAd");
                                        print(exp);
                                      }

                                       */
                  // file name call back
                  print('callBack ${fileModel.name}');
                  // set and request detail file url
                  Navigator.pushNamed(
                      context, VideoStreamingRoute.routeName);
                }

                openAlertDialog(
                    'Stream',
                    widget.videoModel.season_list.first
                        .episode_list.first.file_model_list,
                    callBack,
                    Icons.video_settings_outlined);
              }
              else{
                void callBack(FileModel fileModel)async{
                  /*
                                      try{
                                        _interstitialAd.show();
                                        int point = Provider.of<VideoProvider>(context, listen: false).point;
                                        await Provider.of<VideoProvider>(context, listen: false).setPoint(point + 5);
                                      }catch(exp){
                                        print("_interstitialAd.show exp");
                                        print(exp);
                                      }

                                       */
                  Navigator.pushNamed(context, RewardPage.routeName);
                }
                openAlertDialog(
                    'No Enough Point',
                    [FileModel(0, ResolutionModel(0,"Get Point, Stream Cost $streamCost , Downlaod Cost $downloadCost"), "name", 0)],
                    callBack,
                    Icons.video_settings_outlined);
              }

              /*
              void callBack(FileModel fileModel) {
                // file name call back
                print('callBack ${fileModel.name}');
                // set and request detail file url
                // TDL : download function
                Navigator.pushNamed(context, VideoStreamingRoute.routeName);
              }

              openAlertDialog('Stream', episodeModel.file_model_list, callBack,
                  Icons.video_settings_outlined);

               */
            },
          ),
          Spacer(),
          _favButton(),
          Spacer(),
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xff212020),
            child: IconButton(
              color: mainColor,
              icon: Icon(Icons.file_download),
              onPressed: () {
                void callBack(FileModel fileModel) {
                  // file name call back
                  print('callBack ${fileModel.name}');
                  // set and request detail file url
                  // TDL : download function
                  Navigator.pushNamed(context, VideoDownloadRoute.routeName);
                }

                openAlertDialog('Download', episodeModel.file_model_list,
                    callBack, Icons.file_download);
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _favButton() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Color(0xff212020),
      child: IconButton(
        color: mainColor,
        icon: (favorite) ? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
        onPressed: () async {
          print('VideoDetailRoute->addToFavorite onPressed');
          //
          await addToFav(widget.videoModel);
        },
      ),
    );
  }

  Future<void> notifyAndGoReward(){
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BlurredContainerFull(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            title: Text("Point does not enough!"),
            //content: Text('စျေးခြင်းထဲ ထည့်ပြီးပါပြီ'),
            content: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1,
              child: Text("""
                You don't have enough point to stream  or download this video. Tap ok and get points \n
                stream cost $streamCost \n
                download cost $downloadCost
              """),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Get Point'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, RewardPage.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> openAlertDialog(String title, List<FileModel> fileModelList,
      Function callBackFunction, IconData icon) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return BlurredContainerUpdate(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            title: Text(title),
            //content: Text('စျေးခြင်းထဲ ထည့်ပြီးပါပြီ'),
            content: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 1,
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: fileModelList.length,
                itemBuilder: (context, index) {
                  return BlurredContainerUpdate(
                    child: ListTile(
                      title: Text(fileModelList[index].resolution.name),
                      trailing: Icon(
                        icon,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Provider.of<VideoProvider>(context, listen: false)
                            .setFileModelDetail(fileModelList[index]);
                        callBackFunction(fileModelList[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void addToFav(VideoModel videoModel) async {
    List<dynamic> data = await checkFav(videoModel);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favString = prefs.getString('favorite') ?? '[]';
    List<dynamic> favList = jsonDecode(favString);
    if (data[0] == false) {
      favList.add(widget.videoModel.toJson());
      favorite = true;
    } else {
      favList.removeAt(data[1]);
      favorite = false;
    }
    await prefs.setString('favorite', jsonEncode(favList));
    setState(() {});
  }

  Future<List<dynamic>> checkFav(VideoModel videoModel) async {
    bool result = false;
    int index = 0;
    int tempIndex = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favString = prefs.getString('favorite') ?? '[]';
    List<dynamic> favList = jsonDecode(favString);
    favList.forEach((element) {
      final VideoModel video = VideoModel.fromJson(element);
      if (video.id == videoModel.id) {
        result = true;
        index = tempIndex;
      }
      tempIndex++;
    });
    List<dynamic> data = [result, index];
    return data;
  }
}


/*
old

// background asset image
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/poster_portraits/1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [transparentColor, scaffoldBackgroundColor],
                        stops: [0.0, 0.75],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                    ),
                  ),
                  // loading network image overlay
                  Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  // network image poster
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.videoModel.poster_landscape),
                        fit: BoxFit.cover,
                      ),
                    ),
                    foregroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [transparentColor, scaffoldBackgroundColor],
                        stops: [0.0, 0.75],
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                      ),
                    ),
                  ),
 */