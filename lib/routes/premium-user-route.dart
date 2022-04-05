import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumUserRoute extends StatelessWidget {
  static String routeName = "/premium-user-route";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium User Only"),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Premium User များသာ ကြည့်ရှုနိုင်ပါသည်။ တစ်လလျှင် တစ်ထောင် ကျပ်သာ ကျသင့်မည့် premium user account ကို အောက်က ခလုပ်ကို နှိပ်ပြီး တိုးမြှင့်နိုင်ပါပြီ။')),
      ),
      floatingActionButton: Builder(
        builder: (context){
          return FloatingActionButton.extended(onPressed: (){
            print('premium button on pressed');
            // contact to admin / facebook page with url launcher
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Call 0912345678 to upgrade premium account"),
            ));
            OpenFacebook.openFacebook();
          }, label: Text("Upgrade to Premium User"));
        },
      ) ,
    );
  }
}


class OpenFacebook{
  static void openFacebook() async{
    /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
    String fbProtocolUrl = "fb://page/110486103786309";
    String fallbackUrl = "https://www.facebook.com/mmsoftware100";
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
