

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/chat/chat_screen.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:marketplace_app/splash.dart';

import '../extra/location_screen.dart';
import '../myadd_screen.dart';

class NavigationAddress extends StatefulWidget {

  @override
  _NavigationAddressState createState() => _NavigationAddressState();
}

class _NavigationAddressState extends State<NavigationAddress> {
  bool isSigned = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return LocationScreen();
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
