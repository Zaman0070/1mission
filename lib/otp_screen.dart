import 'package:adobe_xd/pinned.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/Initial%20Screens/language_screen.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/city_screen.dart';
import 'package:marketplace_app/services/phone_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import 'home.dart';

class OtpScreen extends StatefulWidget {
  static const String id = 'Otp';
  final String number;
  final String verId;
  OtpScreen({
    @required this.number,
    @required this.verId,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool _loading = false;
  String error = '';

  PhoneService _service = PhoneService();


  var text1 = TextEditingController();
  var text2 = TextEditingController();
  var text3 = TextEditingController();
  var text4 = TextEditingController();
  var text5 = TextEditingController();
  var text6 = TextEditingController();

  Future<void> phoneCredential(BuildContext context, String otp) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verId, smsCode: otp);
      // need to oto validate or no

      final authResult = await _auth.signInWithCredential(credential);
      final User user = authResult.user;
      final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String fcmToken = await firebaseMessaging.getToken();
      //_auth.currentUser?.linkWithCredential(credential);

      if (user != null) {
        _service.users.doc(user.uid).set({
          'uid': user.uid,
          'mobile': user.phoneNumber,
          'address': 'Where do want to buy/Sell Products',
          'name': '',
          'imageUrl': 'https://icon-library.com/images/unknown-person-icon/unknown-person-icon-10.jpg',
          'followers' : [],
          'following': [],
          'description': 'Add Some Description',
          'device_token': fcmToken,

        }).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => CityScreen()));
        }).catchError((error) => print('failed to add user : $error'));
      } else {
        print('login Failed');
        if (mounted) {
          setState(() {
            error = 'login failed';
          });
        }
      }
    } catch (e) {
      print(e.toString());
      if (mounted) {
        setState(() {
          error = 'Invalid OTP';
        });
      }
    }
  }

  final CountdownController controller = CountdownController(autoStart: true);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: [
            Container(
              height: 27.h,
              width: 100.w,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Pinned.fromPins(
                    Pin(size: 100, end: 130.0),
                    Pin(size: 100.0, middle: 0.5),
                    child:
                        // Adobe XD layer: 'Ellipse 20' (shape)
                        Image.asset(
                      'assets/icons/logo.png',
                      height: 10.h,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                  Pinned.fromPins(
                      Pin(size: 100.w, end: 150.0), Pin(size: 100.0, middle: 1),
                      child:
                          // Adobe XD layer: 'Ellipse 20' (shape)
                          Center(
                        child: Text(
                          'Welcome To Login',
                          style: TextStyle(
                              color: Theme.of(context).splashColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 26.sp),
                        ),
                      )),
                  Pinned.fromPins(
                    Pin(size: 35.0, end: 50.0),
                    Pin(size: 35.0, middle: 0.2497),
                    child:
                        // Adobe XD layer: 'Ellipse 20' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                          width: 6.0,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 27.0, middle: 0.23),
                    Pin(size: 27.0, start: 26.0),
                    child:
                        // Adobe XD layer: 'Ellipse 21' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 6.0, color: Theme.of(context).shadowColor),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 35.0, end: 100.0),
                    Pin(size: 35.0, middle: 0.5),
                    child:
                        // Adobe XD layer: 'Ellipse 20' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 6.0, color: Theme.of(context).shadowColor),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 20.0, middle: 0.90),
                    Pin(size: 20.0, start: 180.0),
                    child:
                        // Adobe XD layer: 'Ellipse 21' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 4.0, color: Theme.of(context).shadowColor),
                      ),
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 15.0, middle: 0.1),
                    Pin(size: 15.0, start: 140.0),
                    child:
                        // Adobe XD layer: 'Ellipse 21' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        border: Border.all(
                            width: 4.0, color: Theme.of(context).shadowColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 70.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'OTP Verification',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enter the OTP sent to',
                          style: TextStyle(
                              fontSize: 13.sp, color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text(
                          widget.number,
                          style: TextStyle(
                              fontSize: 13.sp,
                              //color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Login()));
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(2.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  //border: OutlineInputBorder(),
                                  ),
                              controller: text1,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  node.nextFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  ),
                              controller: text2,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  node.nextFocus();
                                }
                                if(value.length==0){
                                  node.previousFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  ),
                              controller: text3,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  node.nextFocus();
                                }
                                if(value.length==0){
                                  node.previousFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  ),
                              controller: text4,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  node.nextFocus();
                                }
                                if(value.length==0){
                                  node.previousFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  ),
                              controller: text5,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  node.nextFocus();
                                }
                                if(value.length==0){
                                  node.previousFocus();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  ),
                              controller: text6,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                if (value.length == 1) {
                                  if (text1.text.length == 1) {
                                    if (text2.text.length == 1) {
                                      if (text3.text.length == 1) {
                                        if (text4.text.length == 1) {
                                          if (text5.text.length == 1) {
                                            String _otp =
                                                '${text1.text}${text2.text}'
                                                '${text3.text}${text4.text}'
                                                '${text5.text}${text6.text}';
                                            setState(() {
                                              _loading = true;
                                              phoneCredential(context, _otp);
                                            });

                                            // login

                                          }
                                        }
                                      }
                                    }
                                  }
                                } else {
                                  _loading = false;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_loading)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    InkWell(
                      onTap: () {
                        String number = widget.number;
                        _service.verificationPhoneNumber(context, number);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                String number = widget.number;
                                _service.verificationPhoneNumber(
                                    context, number);
                                controller.restart();
                              },
                              child: Text(
                                'Resend on',
                                style: TextStyle(
                                  fontFamily: 'Antonio',
                                  fontSize: 11.sp,
                                  color: Color(0xff64D2FF),
                                  letterSpacing: 0.9999999775924079,
                                  fontWeight: FontWeight.bold,
                                  height: 1.212598461619654,
                                ),
                              ),
                            ),
                            Countdown(
                              seconds: 60,
                              build: (_, double time) => Text(
                                time.toString(),
                                style: TextStyle(
                                  fontFamily: 'Antonio',
                                  fontSize: 11.sp,
                                  color: Color(0xff64D2FF),
                                  letterSpacing: 0.9999999775924079,
                                  fontWeight: FontWeight.bold,
                                  height: 1.212598461619654,
                                ),
                              ),
                              controller: controller,
                              //interval: Duration(milliseconds: 100),
                              onFinished: () {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text('Timer is done!'),
                                //   ),
                                // );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ),
          ],
        ));
  }
}
