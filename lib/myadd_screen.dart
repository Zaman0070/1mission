import 'package:flutter/material.dart';
import 'package:marketplace_app/my_adds.dart';
import 'package:sizer/sizer.dart';

class MyAdsScreen extends StatefulWidget {


  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          'assets/icons/logo.png',
          height: 4.5.h,
          color: Theme.of(context).splashColor,
        ),
      ),
      body: ListView(
        children: [
          MyAdds(),
        ],
      ),
    );
  }
}
