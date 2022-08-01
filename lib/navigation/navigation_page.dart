import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/splash.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isSigned = false;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return MainScreen();
        }
        if(snapShot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ));

        }
        return Login();

      },
       // Navigator.of(context).pop();
        //Navigator.push(context,  SlidingAnimationRoute(builder: (context) => landingPage));
    );
  }
}
