import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';

class NavigationAddData extends StatefulWidget {
  @override
  _NavigationAddDataState createState() => _NavigationAddDataState();
}

class _NavigationAddDataState extends State<NavigationAddData> {
  bool isSigned = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot) {
        if (snapShot.data != null) {
          return SellCategories();
        }
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ));
        }
        return Login();
      },
    );
  }
}
