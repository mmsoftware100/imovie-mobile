import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:imovie/data/AdHelper.dart';
import 'package:imovie/data/const-data.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:provider/provider.dart';

class RewardPage extends StatefulWidget {
  static const String routeName = '/reward-page';
  const RewardPage({Key key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {

  RewardedAd _rewardedAd;
  bool _rewardReady = false;
  bool _done = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    RewardedAd.load(
        adUnitId: AdHelper.rewardedAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            this._rewardedAd = ad;
            this._rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (RewardedAd ad) =>
                  print('$ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (RewardedAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
              onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
            );
            setState(() {
              _rewardReady = true;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        )
    );




  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Points"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _statusWidget(),
          SizedBox(height: 20,),
          Center(
            child: Text("You have " +Provider.of<VideoProvider>(context, listen: true).point.toString() +" points"),
          ),
        ],
      ),
      floatingActionButton: _loadOrShowReward(),
    );
  }

  Widget _statusWidget(){
    if(_done) return Text("Congratulations!");
    return _rewardReady ?
    Center(
      child: Text("Points are ready!"),
    ) :
    Center(
      child: Text("Getting point...."),
    );
  }
  Widget _loadOrShowReward(){

    if(_rewardReady){
      return FloatingActionButton.extended(
        onPressed: (){
          print("getPoint onPressed");
          _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem rewardItem) async{
            // Reward the user for watching an ad.

            int point = Provider.of<VideoProvider>(context, listen: false).point;
            //await Provider.of<VideoProvider>(context, listen: false).setPoint(point + adsReward);
            await Provider.of<VideoProvider>(context, listen: false).setPoint(point + 10000);
            setState(() {
              _rewardReady = false;
              _done = true;
            });
          });
        },
        icon: Icon(Icons.monetization_on),
        label: Text("Get Points"),
      );
    }
    else{
      if(_done){
        return Container();
      }
      return FloatingActionButton.extended(
        onPressed: (){
          print("loading onPressed");

        },
        icon: Container(width: 20,height: 20, child: CircularProgressIndicator()),
        label: Text(" loading"),
      );
    }
    /*


     */

  }
}
