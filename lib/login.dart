import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:legacy_progress_dialog/legacy_progress_dialog.dart';
import 'package:marketplace_app/pages/city_screen.dart';
import 'package:marketplace_app/services/phone_service.dart';

import 'package:sizer/sizer.dart';

enum AuthFormType { phone }

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool validate = false;
  int length;
  var countryCodeController = TextEditingController();
  var phoneNumberController = TextEditingController();
  PhoneService _service = PhoneService();

  List<String> country(BuildContext context) =>
      ['+92','+974',];

  Widget _appBar(title, fieldValue) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).backgroundColor,
      automaticallyImplyLeading: false,
      shape: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      //centerTitle: true,
      title: Text(
        '$title > $fieldValue',
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _listViews({fieldValue, list, textController}) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _appBar('Choose Country', fieldValue),
          ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    /// return back
                    Navigator.pop(context);
                    textController.text = list[index];
                  },
                  title: Text(list[index]),
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      loadingText: 'Please wait',
      progressIndicatorColor: Theme.of(context).primaryColor,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      'Enter your mobile number',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: (){
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _listViews(
                                      ///
                                      fieldValue: 'area*',
                                      list: country(context),
                                      textController: countryCodeController,
                                    );
                                  });
                            },
                            child: TextField(
                              onTap: (){
                                FocusScope.of(context).unfocus();
                              },
                              autofocus: false,
                              controller: countryCodeController,
                              enabled: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down,),
                                counterText: '8',
                                // contentPadding: EdgeInsets.all(23),
                                labelText: 'Code',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 2,
                            child: TextField(
                              autofocus: false,
                             onTap: (){
                               FocusScope.of(context).unfocus();
                             },
                              onChanged: (value) {
                                length = value.length;
                                setState(() {});
                                if (countryCodeController.text == '+92') {
                                  if (value.length == 10) {
                                    setState(() {
                                      validate = true;
                                    });
                                  }
                                  if (value.length < 10) {
                                    setState(() {
                                      validate = false;
                                    });
                                  }
                                }



                                //  if(countryCodeController.text == '+967'){
                                //   if (value.length == 9) {
                                //     setState(() {
                                //       validate = true;
                                //     });
                                //   }
                                //   if (value.length < 9) {
                                //     setState(() {
                                //       validate = false;
                                //     });
                                //   }
                                // }
                                else{
                                  if (value.length == 8) {
                                    setState(() {
                                      validate = true;
                                    });
                                  }
                                  if (value.length < 8) {
                                    setState(() {
                                      validate = false;
                                    });
                                  }
                                }
                              },
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.all(23),
                                  labelText: 'Number',
                                  hintText: 'Enter your phone number',
                                  hintStyle: TextStyle(
                                      fontSize: 15, color: Colors.grey)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'We will send you 6-digits verification code',
                      style:
                          TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    InkWell(
                      onTap: () {
                        print(length);
                        if (countryCodeController.text == '+92'){
                          if (length == 10) {
                            progressDialog.show();
                            String number =
                                '${countryCodeController.text}${phoneNumberController.text}';
                            _service.verificationPhoneNumber(context, number);
                          } else if (length < 10) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter a valid number")));
                          }
                        }
                      else{
                          if (length == 8) {
                            progressDialog.show();
                            String number =
                                '${countryCodeController.text}${phoneNumberController.text}';
                            _service.verificationPhoneNumber(context, number);
                          } else if (length < 8) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Enter a valid number")));
                          }
                        }
                      },
                      child: Container(
                        height: 6.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.3),
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          'Continues',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Theme.of(context).splashColor,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => CityScreen()));
                      },
                      child: Container(
                        height: 6.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 0.3),
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text(
                          'Skip',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Theme.of(context).splashColor,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ),
          ],
        ));
  }
}
