

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/pages/profile.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:marketplace_app/splash.dart';

import '../product_details.dart';

class NavigationProductDetails extends StatefulWidget {
  int index;
  NavigationProductDetails({this.index});


  @override
  _NavigationAddprofile createState() => _NavigationAddprofile();
}

class _NavigationAddprofile extends State<NavigationProductDetails> {
  bool isSigned = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return ProductDetailScreen();
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
