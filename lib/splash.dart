import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:marketplace_app/Initial%20Screens/language_screen.dart';
import 'package:marketplace_app/navigation/navigation_page.dart';
import 'package:sizer/sizer.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => NavigationPage()))),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Hero(
              tag: 'logo',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10.h,
                    height: 10.h,
                    child: Image.asset(
                      'assets/icons/logo.png',
                      color: Theme.of(context).splashColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    //width: 250.0,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Theme.of(context).splashColor,
                        fontFamily: 'Bobbers',
                      ),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('One Mission'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),
          SpinKitChasingDots(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.white : Colors.white54,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
