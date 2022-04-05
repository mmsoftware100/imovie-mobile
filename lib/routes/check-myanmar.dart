import 'package:flutter/material.dart';
import 'package:imovie/routes/login-page.dart';
import 'package:imovie/routes/main-route.dart';


class CheckMyanmar extends StatefulWidget {
  static final routeName = "/check-myanmar";
  @override
  _CheckMyanmarState createState() => _CheckMyanmarState();
}

class _CheckMyanmarState extends State<CheckMyanmar> {
  String username;
  String password;

  LoadingOverlay overlay;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // heading
          Container(
            height: size.height / 4,
            //color: Colors.white,
            child: Stack(
              children: [
                // app title logo

                Align(
                  alignment: Alignment.center,
                  child: Container(
                    //color: Colors.green,
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    width: size.width / 1.5,
                    child: Image(
                      image: AssetImage('assets/images/one_five.png'),
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
                      if(username == "" || username == null ) {
                        print('invalid input value');
                        return;
                      }
                      loginAccount(username: username, context: context);

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
                        child: Text('Proceed',
                          style: TextStyle(color: Colors.white),
                        ),

                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),


        ],
      ),
    );
  }

  void registerAccount(BuildContext context){
    print('registerAccount is called');
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("📞 to register account, please contact to admin."),
    ));
  }
  void loginAccount({String username, BuildContext context}){
    print('loginAccount is called with username $username');
    // BlocProvider.of<UserBloc>(context).add(UserLoginEvent(username: username, password: password ));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("checking myanmar."),
    ));
    LoadingOverlay.of(context).show();
    Future.delayed(Duration(seconds: 5),(){
      if(username == "11111" ) Navigator.pushReplacementNamed(context, MainRoute.routeName);
      else{
        if(Navigator.canPop(context)){
          // hide loading overlay
          Navigator.pop(context);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Wrong passcode, try again."),
          ));
        }
      }
    });
  }


}
