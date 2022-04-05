import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:imovie/routes/main-route.dart';
import 'package:url_launcher/url_launcher.dart';


class OTPScreen extends StatefulWidget {
  static final routeName = "/otp";
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var firstController = TextEditingController();
  var secondController = TextEditingController();
  var thirdController = TextEditingController();
  var fourthController = TextEditingController();
  FocusNode secondFocusNode = FocusNode();
  FocusNode thirdFocusNode = FocusNode();
  FocusNode fourthFocusNode = FocusNode();

  final Color textColor = Colors.red;

  @override
  Widget build(BuildContext context) {

    wrongOTP() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 150.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Wrong OTP Code!\nGet OTP Code from Facebook Page.',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      Timer(
          Duration(seconds: 3),
              () {
            // close dialog
            Navigator.pop(context);
            _openFacebook();
          }
      );
    }
    loadingDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 150.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitRing(
                    color: textColor,
                    size: 40.0,
                    lineWidth: 2.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Please Wait..',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      Timer(
          Duration(seconds: 3),
              () {
                if(firstController.text == "1" && secondController.text == "2" && thirdController.text == "3" && fourthController.text == "4"){
                  Navigator.pushReplacementNamed(context,MainRoute.routeName);
                }
                else{
                  Navigator.pop(context);
                  wrongOTP();

                }
              }
      );
    }


    getPassword() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 350.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SpinKitRing(
                    color: Colors.red,
                    size: 40.0,
                    lineWidth: 2.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Get OTP Code from Facebook Page.',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      Timer(
          Duration(seconds: 3),
              () {

            // close dialog
            Navigator.pop(context);
            _openFacebook();
          }
      );
    }

    nestedAppBar() {
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar_bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'Enter 4 Digit OTP',
                    style: TextStyle(
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            SizedBox(height: 30.0),
            Container(
              margin: EdgeInsets.only(right: 30.0, left: 30.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Enter the OTP code from Our Facebook Page.',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Signika Negative',
                      color: Colors.grey[500],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // OTP Box Start
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // 1 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: firstController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context)
                                .requestFocus(secondFocusNode);
                          },
                        ),
                      ),
                      // 1 End
                      // 2 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          focusNode: secondFocusNode,
                          controller: secondController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(thirdFocusNode);
                          },
                        ),
                      ),
                      // 2 End
                      // 3 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          focusNode: thirdFocusNode,
                          controller: thirdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            FocusScope.of(context)
                                .requestFocus(fourthFocusNode);
                          },
                        ),
                      ),
                      // 3 End
                      // 4 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 1.5,
                              spreadRadius: 1.5,
                              color: Colors.grey[200],
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          focusNode: fourthFocusNode,
                          controller: fourthController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          onChanged: (v) {
                            loadingDialog();
                          },
                        ),
                      ),
                      // 4 End
                    ],
                  ),
                  // OTP Box End
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Didn\'t receive OTP Code!',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Signika Negative',
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(width: 10.0),

                    ],
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      loadingDialog();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: textColor,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Signika Negative',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: nestedAppBar(),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            // open messenger
            getPassword();
          },
          icon: Icon(Icons.message),
          label: Text('Get OTP Code')),
    );
  }
}

void _openFacebook() async{
  /* numeric value ကို https://lookup-id.com/ မှာ ရှာပါ */
  // ngwe-shar-soe page id 100577978558887
  // myanquizpro 100613051993989
  String fbProtocolUrl = "fb://page/100613051993989";
  String fallbackUrl = "https://www.facebook.com/myanquiz";
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
