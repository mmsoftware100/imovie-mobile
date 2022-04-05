import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:imovie/components/account-component.dart';
import 'package:imovie/components/app-title-component.dart';
import 'package:imovie/components/blurred-container.dart';
import 'package:imovie/components/download-component.dart';
import 'package:imovie/components/favorite-component.dart';
import 'package:imovie/components/main-component.dart';
import 'package:imovie/components/mmcafe-component.dart';
import 'package:imovie/components/news-component.dart';
import 'package:imovie/data/AdHelper.dart';
import 'package:imovie/model/user-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/search-route.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRoute extends StatefulWidget {
  static const String routeName = '/main-route';

  @override
  _MainRouteState createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int _selectedIndex = 0;

  /*

  // TODO: Change ad height
  int adHeight = 0;
  // TODO: Add a BannerAd instance

  BannerAd _ad ;
  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;


  InterstitialAd _interstitialAd;

   */

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // data initialiation...


    /*
    // TODO: Create a BannerAd instance
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          print('Ad->Banner loaded');
          setState(() {
            _isAdLoaded = true;
            adHeight = 100;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          //ad.dispose();
          print('Ad->Banner load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    // TODO: Load an ad
    _ad.load();



    // load interstitial ad
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


    _dataRefresh();

    _initialize();

    _initializeLogin();
  }


  void _initializeLogin()async{
    print("initializeLogin");
    String newImei = await ImeiPlugin.getImei();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = await prefs.getString("username") ?? "username_demo";
    String password = await prefs.getString("password") ?? "password_demo";
    UserModel userModel = await Provider.of<VideoProvider>(context, listen: false).userLogin(username, password);
    print("userModel is ");
    print(userModel.toJson());
  }
  void _initialize()async{
    int point = await Provider.of<VideoProvider>(context, listen: false).getPoint();
    print("initial point is $point");
    _checkPermission();
  }


  Future<bool> _checkPermission() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }
  /*
  Widget _adContainer(){
    return Container(
      child: AdWidget(ad: _ad),
      width: _ad.size.width.toDouble(),
      height: adHeight.toDouble(),
      alignment: Alignment.center,
    );
  }

   */

  void _dataRefresh(){
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListFeatured();
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListLatestUpdate();
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListMovie();
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListSeries();
    Provider.of<VideoProvider>(context, listen: false)
        .requestCategoryModelList();


    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(11);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(12);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(13);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(14);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(15);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(16);
    Provider.of<VideoProvider>(context, listen: false)
        .requestVideoModelListCategoryOneTime(17);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          //leading: Container(child: Icon(Icons.account_balance_wallet_outlined)),
        /*
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Provider.of<VideoProvider>(context, listen: true).point.toString() +" points"),
        ),

         */
        /*
          leading: Image.asset(
            'assets/images/logo.png',
            scale: 8.0,
          ),

         */
          title: Row(
            children: [
              Icon(Icons.account_balance_wallet_outlined),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                child: Text(Provider.of<VideoProvider>(context, listen: true).point.toString() +" points"),
              ),
            ],
          ),
          /*
          title: Row(
            children: [

              AppTitleComponent(),
            ],
          ),

           */
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, SearchRoute.routeName);
                //Navigator.push(context,MaterialPageRoute(builder: (context) => SearchPage()));
              },
            )
          ]),
      //body: listView(),
      body: Column(
        children: [
          // _adContainer(),
          Expanded(
            child: Stack(children: [
              _widgetCase(),
              // _bottomNavigationBar(),
              Align(
                alignment: Alignment.bottomCenter,
                child: _bottomNavigationBar(),
              )
            ]),
          ),
        ],
      ),
      // bottomNavigationBar: _bottomNavigationBar(),
      //floatingActionButton: _fab(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _widgetCase() {
    switch (_selectedIndex) {
      case 0:
        // return mmcafe();
        //return NewsComponent();
        return _pullToRefresh();
        break;
      case 1:
        return FavoriteComponent();
        break;
        /*
      case 2:
        return _pullToRefresh();
        //return MainComponent();
        break;

         */
      case 2:
        bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
        return isIOS ? Container() : DownloadComponent();
        break;
      case 3:
        return AccountComponent();
        break;
      default:
        return Center(
          child: Text('no data'),
        );
        break;
    }
  }

  Widget _bottomNavigationBar() => BlurredContainer(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFDC1E16),
          unselectedItemColor: Colors.white,
          unselectedFontSize: 10,
          selectedFontSize: 12,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            /*
            BottomNavigationBarItem(
              icon: (_selectedIndex == 0)
                  ? Icon(Icons.message)
                  : Icon(Icons.message_outlined),
              label: 'Message',
            ),

             */
            BottomNavigationBarItem(
              icon: (_selectedIndex == 2)
                  ? Icon(Icons.home)
                  : Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: (_selectedIndex == 1)
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline),
              label: 'Favorite',
            ),
            /*
        BottomNavigationBarItem(
          icon: Icon(
            Icons.school,
            color: Colors.blue,
            size: 10,
          ),
          label: '',
        ),

         */
            BottomNavigationBarItem(
              icon: (_selectedIndex == 3)
                  ? Icon(Icons.file_download)
                  : Icon(Icons.download_outlined),
              label: 'Download',
            ),

            BottomNavigationBarItem(
              //icon: ( _selectedIndex == 4 ) ? Icon(Icons.info) :  Icon(Icons.info_outline_rounded),
              icon: (_selectedIndex == 4)
                  ? Icon(Icons.person)
                  : Icon(Icons.perm_identity),
              label: 'Menu',
            ),

          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            print("onTap on " + index.toString());
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );

  Widget _fab() => Container(
        width: 75,
        child: FittedBox(
          child: FloatingActionButton(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  (_selectedIndex == 2) ? Icons.home : Icons.home_outlined,
                  color: (_selectedIndex == 2) ? Colors.white : Colors.white,
                  size: 20,
                ),
                Text('Home',
                    style: TextStyle(
                      fontSize: (_selectedIndex == 2) ? 10 : 8,
                      color: (_selectedIndex == 2) ? Colors.blue : Colors.grey,
                    ))
              ],
            ),
            //child: Icon(Icons.privacy_tip,size: 25,),
            backgroundColor: Colors.black,
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
        ),
      );

  Widget _pullToRefresh() {
    return SmartRefresher(
        //enablePullDown: false,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: () async{
          print("onRefresh");
          /*
          try{
            _interstitialAd.show();
            int point = Provider.of<VideoProvider>(context, listen: false).point;
            await Provider.of<VideoProvider>(context, listen: false).setPoint(point + 5);
          }
          catch(exp){
            print("can't show _interstitialAd");
            print(exp);
          }

           */

          _dataRefresh();
          return Future.delayed(Duration(milliseconds: 10000), () {
            print("refreshCompleted");
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
            _refreshController.refreshCompleted();
          });
        },
        child: MainComponent()
    );
  }
}
