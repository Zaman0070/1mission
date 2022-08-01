

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/pages/profile.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:marketplace_app/splash.dart';

class NavigationProfile extends StatefulWidget {


  @override
  _NavigationAddprofile createState() => _NavigationAddprofile();
}

class _NavigationAddprofile extends State<NavigationProfile> {
  bool isSigned = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return  Profile();
        }
        if(snapShot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ));
        }
        return Login();
      },

    );
  }
}
