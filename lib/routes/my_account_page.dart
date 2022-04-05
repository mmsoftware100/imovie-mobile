import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccountPage extends StatefulWidget {

  static const String routeName = '/my-account-page';
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}


class _MyAccountPageState extends State<MyAccountPage> {

  String imei = "N/A";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getImei();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("plz screenshot this page and sent to facebook page to activate this device "),
            SizedBox(height: 50,),
            Text(imei)
          ],
          ),
      ),
      floatingActionButton: _fab(),
      );
  }

  void _getImei()async{
    String newImei = await ImeiPlugin.getImei();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", newImei);
    await prefs.setString("password", newImei);
    setState(() {
      imei = newImei;
    });
  }

  Widget _fab(){
    return FloatingActionButton.extended(
        onPressed: (){
          _openFacebook();
        },
        label: Text("Facebook Page"),
        icon: Icon(Icons.login),
    );
  }

  void _openFacebook() async{
    /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
    // ngwe-shar-soe page id 100577978558887
    // myanquizpro 100613051993989
    String fbProtocolUrl = "fb://profile/100577978558887";
    String fallbackUrl = "www.facebook.com/myanquiz";
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
}
