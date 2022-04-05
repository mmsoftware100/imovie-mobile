import 'package:flutter/material.dart';
import 'package:imovie/model/user-model.dart';
import 'package:imovie/provider/VideoProvider.dart';
import 'dart:ui' as ui;

import 'package:imovie/routes/main-route.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget {
  static final routeName = "/loign-page";
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;

  LoadingOverlay overlay;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // heading
            Container(
              height: size.height / 4,
              //color: Colors.white,
              child: Stack(
                children: [
                  // custom painter
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomPaint(
                      size: Size(size.width / 2, size.height / 4),
                      painter: CustomCardShapePainter(
                          startColor: Colors.green,
                          endColor: Colors.lightGreen),
                    ),
                  ),
                  // app title logo

                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      //color: Colors.green,
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      width: size.width / 1.5,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // login form
            Column(
              children: [
                // username input
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white)
                    ),
                    child: TextField(
                      onChanged: (String str){
                        setState(() {
                          username = str;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        disabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.red)
                        ),
                        hintText: 'user01',
                        labelText: 'Username',
                        //hintStyle: TextStyle(color: Colors.white),
                        //labelStyle: TextStyle(color: Colors.white),
                        //fillColor: Colors.black

                      ),
                    ),
                  ),
                ),
                // password input
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Container(
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.white)
                    ),
                    child: TextField(
                      obscureText: true,
                      onChanged: (String str){
                        setState(() {
                          password = str;
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        focusedBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.white)
                        ),
                        disabledBorder: OutlineInputBorder(
                          //borderSide: const BorderSide(color: Colors.red)
                        ),
                        hintText: '****',
                        labelText: 'Password',
                        //hintStyle: TextStyle(color: Colors.white),
                        //labelStyle: TextStyle(color: Colors.white),
                        //fillColor: Colors.white

                      ),
                    ),
                  ),
                ),
                // sign in button
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Builder(
                    builder:(context) => InkWell(
                      onTap: (){
                        print('login onTap');
                        // validate username and password
                        //if(this.username == null || username = "" || password == null || password = ""){

                        //}
                        if(username == "" || password == "" || username == null || password == null) {
                          print('invalid input value');
                          return;
                        }
                        loginAccount(username: username, password: password, context: context);

                      },
                      child: Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.green,
                                Colors.lightGreen
                              ]
                          ),
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MaterialButton(
                          child: Text('Login',
                            style: TextStyle(color: Colors.white),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),

                // free user in button
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Builder(
                    builder:(context) => InkWell(
                      onTap: (){
                        print('free user onTap');
                        Navigator.pushReplacementNamed(context, MainRoute.routeName);
                        //Navigator.pushNamed(context, MainRoute.routeName);
                      },
                      child: Container(
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey,
                                Colors.black26
                              ]
                          ),
                          //border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MaterialButton(
                          child: Text('Skip Login',
                            style: TextStyle(color: Colors.white),
                          ),

                        ),
                      ),
                    ),
                  ),
                ),
                // forget password text link
                Align(
                  alignment: Alignment.centerRight,
                  child: Builder(
                    builder:(context) => InkWell(
                      onTap: (){
                        print('Forget Password onTap');
                        forgetPassword(context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text('Forget Password ?' , style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 50,),
            // don't have an account, register here
            Container(
              //height: size.height /6,
              //color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.black),),
                  Builder(
                    builder:(context) => InkWell(
                      onTap: (){
                        print('register onTap');
                        registerAccount(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Register Here",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  void forgetPassword(BuildContext context){
    print('forgetPassword is called');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("📞 ကျေးဇူးပြုပြီး Admin ကို ဆက်သွယ်ပေးပါ။"),
    ));
  }
  void registerAccount(BuildContext context){
    print('registerAccount is called');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("📞 ကျေးဇူးပြုပြီး Admin ကို ဆက်သွယ်ပေးပါ။"),
    ));
  }
  void loginAccount({String username, String password, BuildContext context}) async{
    print('loginAccount is called with username $username, password $password');
    // BlocProvider.of<UserBloc>(context).add(UserLoginEvent(username: username, password: password ));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("signing in..."),
    ));
    LoadingOverlay.of(context).show();
    UserModel userModel = await Provider.of<VideoProvider>(context, listen: false).userLogin(username, password);
    if(Navigator.canPop(context)) {
      // close Loading overlay
      Navigator.pop(context);
    }
    if(userModel == null){
      // login fail
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Login Error. Please try again."),
      ));
    }
    else{
      Navigator.pushReplacementNamed(context, MainRoute.routeName);
    }
  }


}

class CustomCardShapePainter extends CustomPainter {
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter({@required this.startColor, @required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    double radius = 24;
    Paint paint = Paint();
    paint.shader =
        ui.Gradient.linear(Offset(0, size.height), Offset(size.width, 0), [
          //HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
          startColor,
          endColor
        ]);

    final double w = size.width;
    final double h = size.height;
    final pointOneX = -w * 0.2;
    final pointOneY = h * 0.4;

    final pointTwoX = w * 0.4;
    final pointTwoY = h * 0.5;

    final pointThreeX = w * 0.7;
    final pointThreeY = h * 0.6;

    final pointFourX = w * 0.7;
    final pointFourY = h * 0.7;

    final pointFiveX = w * 0.7;
    final pointFiveY = h * 0.9;

    final pointSixX = w * 1.0;
    final pointSixY = h * 1.0;

    Path path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(pointOneX, pointOneY, pointTwoX, pointTwoY)
      ..quadraticBezierTo(pointThreeX, pointThreeY, pointFourX, pointFourY)
      ..quadraticBezierTo(pointFiveX, pointFiveY, pointSixX, pointSixY)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
    /*
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)

       */
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    //throw UnimplementedError();
    return true;
  }
}


class AppLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/app_icon.jpg'),
      fit: BoxFit.fitWidth,
    );
  }
}

class LoadingOverlay {
  bool status;
  BuildContext _context;

  void hide() {
    if(status == false ) return;
    status = false;
    try{
      Navigator.of(_context).pop();
    }catch(exp){
      print(exp);
    }
  }

  void show() {
    status = true;
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (_) => _FullScreenLoader());
    //child: _FullScreenLoader());
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) {
    return LoadingOverlay._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child: Center(child: CircularProgressIndicator()));
  }
}