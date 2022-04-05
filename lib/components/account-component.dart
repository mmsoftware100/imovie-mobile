import 'package:flutter/material.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'package:imovie/routes/login-page.dart';
import 'package:imovie/routes/my_account_page.dart';
import 'package:imovie/routes/reward-page.dart';
import 'package:imovie/routes/tnc.dart';
import 'package:imovie/style/colors.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // _myAccount(context),
        _pointData(context),
        _appVersion(context),
        _goToReward(context),
        _shareTile(context),
        _playStoreRating(context),
        _facebookPage(context),
        Expanded(child: _listView(context)),
      ],
    );
  }

  void _openPlaystore() async{
    /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
    // ngwe-shar-soe page id 100577978558887
    // myanquizpro 100613051993989
    String fbProtocolUrl = "https://play.google.com/store/apps/details?id=com.mmsoftware100.zmovie";
    String fallbackUrl = "https://play.google.com/store/apps/details?id=com.mmsoftware100.zmovie";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      print("launching..."+fbProtocolUrl);
      if (!launched) {
        print("can't launch");
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      print("can't launch exp "+e.toString());
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }


  void _openFacebookPage() async{
    /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
    // ngwe-shar-soe page id 100577978558887
    // myanquizpro 100613051993989
    // zmoive 103375065575475
    String fbProtocolUrl = "fb://page/103375065575475";
    String fallbackUrl = "https://facebook.com/zmoviemmsub";
    try {
      bool launched = await launch(fbProtocolUrl, forceSafariVC: false);
      print("launching..."+fbProtocolUrl);
      if (!launched) {
        print("can't launch");
        await launch(fallbackUrl, forceSafariVC: false);
      }
    } catch (e) {
      print("can't launch exp "+e.toString());
      await launch(fallbackUrl, forceSafariVC: false);
    }
  }

  Widget _pointData(BuildContext context){
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, RewardPage.routeName);
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("Your Points"),
      trailing: Text(
          Provider.of<VideoProvider>(context, listen: true).point.toString() +" points"
      ),
    );
  }

  Widget _myAccount(BuildContext context) {
    return ListTile(
      onTap: () {
        if(Provider.of<VideoProvider>(context, listen: false).userModel == null){
          Navigator.pushNamed(context, MyAccountPage.routeName);
        }
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("My Account"),
      trailing: Text(
          Provider.of<VideoProvider>(context, listen: true).userModel == null ? "free" : "premium"
      ),
    );
  }
  Widget _goToReward(BuildContext context){
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, RewardPage.routeName);
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("Get Points"),
      trailing: Icon(Icons.forward),
    );
  }
  Widget _shareTile(BuildContext context){
    return ListTile(
      onTap: (){
        // Navigator.pushNamed(context, RewardPage.routeName);
        // _openPlaystore();
        Share.share('check out zMovie in Google Playstore https://play.google.com/store/apps/details?id=com.mmsoftware100.zmovie');
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("Share"),
      trailing: Icon(Icons.share),
    );
  }
  Widget _playStoreRating(BuildContext context){
    return ListTile(
      onTap: (){
        // Navigator.pushNamed(context, RewardPage.routeName);
         _openPlaystore();
        // Share.share('check out zMovie in Google Playstore bit.ly/zMoviePlaystore');
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("Rate Up"),
      trailing: Icon(Icons.share),
    );
  }

  Widget _facebookPage(BuildContext context){
    return ListTile(
      onTap: (){
        _openFacebookPage();
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("Facebook Page"),
      trailing: Icon(Icons.share),
    );
  }
  Widget _appVersion(BuildContext context){
    return ListTile(
      onTap: (){
        // _openFacebookPage();
      },
      leading: Icon(Icons.monetization_on, color: Colors.white30,),
      title: Text("App Version"),
      trailing: Text("v1.0.0"),
    );
  }
  Widget _listView(BuildContext context){
    List<String> strList = [
      "Privacy Policy",
    ];
    return ListView(
      children: List.generate(strList.length,
              (index) => ListTile(
                onTap: (){
                  Navigator.pushNamed(context, TnC.routeName);
                },
                leading: Icon(Icons.menu, color: Colors.white30,), title: Text(strList[index]),)
      ),
    );
  }

  Widget _accountData(){
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _circularAvatar(),
          Expanded(
              child: Center(
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, LoginPage.routeName);
                      },
                      child: Text('Login'))
              )
          )
        ],
      ),
    );
  }

  Widget _circularAvatar(){
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: AssetImage('assets/images/avatar.png'),
      child: Align(
        alignment: Alignment.topRight,
        child: CircleAvatar(
          radius: 15.5,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.camera_alt,
            color: mainColor,
            size: 16.0,
          ),
        ),
      ),
    );
  }
  Widget _accountData2(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Spacer(),
          Center(
            child: Hero(
              tag: 'profile_image',
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/avatar.png'),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 15.5,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      color: mainColor,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          Text('Username')
        ],
      ),
    );
  }
}
