import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marketplace_app/pages/city.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/widget/city_box_widget.dart';
import 'package:sizer/sizer.dart';

class CityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: ListView(
            children: [
              SizedBox(height: 5.h),
              Container(
                height: 10.h,
                alignment: Alignment.center,
                child: Image.asset('assets/icons/logo.png',
                    color: Theme.of(context).splashColor),
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Color(0xff8E7FC0),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => MainScreen()));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            clipBehavior: Clip.antiAlias,
                            height: 20.h,
                            decoration: BoxDecoration(
                              // color: check ? Color(0xff8E7FC0) : Color(0xff38205A),
                              color: Color(0xff8b5f3c).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Stack(
                              children: [
                                Pinned.fromPins(
                                  Pin(size: 157, end: 130.0),
                                  Pin(size: 130.0, middle: 2.4),
                                  child:
                                  // Adobe XD layer: 'Ellipse 20' (shape)
                                  Image.asset(
                                    'assets/city/sanas.png',
                                  ),
                                ),
                                Positioned(
                                  top: 10.0,
                                  left: 10.0,
                                  child: Text(
                                    "Sana'a",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  CityBox(
                    onTap: () {
                      displayToastMessage("Coming Soon......", context);
                    },
                    label: 'Aden',
                    imageUrl: 'assets/city/aden.png',
                    color: Color(0xffFD4D4D).withOpacity(0.9),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Color(0xff8E7FC0),
                      onTap: () {
                        displayToastMessage("Coming Soon......", context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.grey.shade600,
                                    Colors.grey.shade800
                                  ]).createShader(bounds);
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              clipBehavior: Clip.antiAlias,
                              height: 20.h,
                              decoration: BoxDecoration(
                                // color: check ? Color(0xff8E7FC0) : Color(0xff38205A),
                                color: Color(0xff9C9C9C).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: [
                                  Pinned.fromPins(
                                    Pin(size: 157, end: 120.0),
                                    Pin(size: 130.0, middle: 1.5),
                                    child:
                                    // Adobe XD layer: 'Ellipse 20' (shape)
                                    Image.asset(
                                      'assets/city/ibb.png',
                                    ),
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    left: 10.0,
                                    child: Text(
                                      "Ibb",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  CityBox(
                    onTap: () {
                      displayToastMessage("Coming Soon......", context);
                    },
                    label: 'Taizz',
                    imageUrl: 'assets/city/taizz.png',
                    color: Color(0xff226c5b).withOpacity(0.9),

                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Color(0xff8E7FC0),
                      onTap: () {
                        displayToastMessage("Coming Soon......", context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.grey.shade600,
                                    Colors.grey.shade800
                                  ]).createShader(bounds);
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              clipBehavior: Clip.antiAlias,
                              height: 20.h,
                              decoration: BoxDecoration(
                                // color: check ? Color(0xff8E7FC0) : Color(0xff38205A),
                                color: Color(0xffFFA578).withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Stack(
                                children: [
                                  Pinned.fromPins(
                                    Pin(size: 157, end: 130.0),
                                    Pin(size: 130.0, middle: 1.5),
                                    child:
                                    // Adobe XD layer: 'Ellipse 20' (shape)
                                    Image.asset(
                                      'assets/city/marib.png',
                                    ),
                                  ),
                                  Positioned(
                                    top: 10.0,
                                    left: 10.0,
                                    child: Text(
                                      "Marib",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  CityBox(
                    onTap: () {
                      displayToastMessage("Coming Soon......", context);
                    },
                    label: 'Hadramont',
                    imageUrl: 'assets/city/hadramout.png',
                    color: Color(0xffeaebe6).withOpacity(0.8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
