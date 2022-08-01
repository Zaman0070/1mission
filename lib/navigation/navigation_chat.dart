

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/chat/chat_screen.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:marketplace_app/splash.dart';

import '../myadd_screen.dart';

class NavigationChat extends StatefulWidget {

  @override
  _NavigationChatState createState() => _NavigationChatState();
}

class _NavigationChatState extends State<NavigationChat> {
  bool isSigned = false;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return ChatScreen();
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
