import 'package:flutter/material.dart';
import 'package:imovie/routes/about.dart';
import 'package:imovie/routes/otp.dart';
import 'package:imovie/routes/privacy-policy.dart';
import 'package:imovie/routes/tnc.dart';

class FakeMainApp extends StatefulWidget {
  static final String routeName = "/fake-main-app";
  @override
  _FakeMainAppState createState() => _FakeMainAppState();
}

class _FakeMainAppState extends State<FakeMainApp> {
  final Color tileColor = Colors.redAccent;
  final Color iconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Datshin")),
      body: Center(child: Text('Welcome,\n\nPress Watch button below.')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(child: Text('Datshin')),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: ListTile(
                tileColor: tileColor,
                leading: Icon(Icons.privacy_tip, color: iconColor,),
                title: Text('Privacy Policy'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushNamed(context, PrivacyPolicy.routeName);

                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: ListTile(
                tileColor: tileColor,
                leading: Icon(Icons.privacy_tip, color: iconColor),
                title: Text('Terms of Conditions'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushNamed(context, TnC.routeName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: ListTile(
                tileColor: tileColor,
                leading: Icon(Icons.privacy_tip, color: iconColor),
                title: Text('About'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutRoute.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.video_collection_rounded),
        label: Text("Watch"),
        onPressed: (){
          Navigator.pushNamed(context, OTPScreen.routeName);
        },
      ),
    );
  }
}


