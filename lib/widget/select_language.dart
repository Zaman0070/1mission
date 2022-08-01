import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

class SelectLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(

          children: [
            SizedBox(height: 40.h,),
            InkWell(
              onTap: () {
                changeLocale(context, 'en');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                // alignment: Alignment.centerLeft,
                height: 9.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor == Colors.white
                      ? Color.fromARGB(255, 206, 205, 205)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                    translate('ford') == 'Ford'
                        ? Icon(Icons.check, color: Colors.green)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              onTap: () {
                changeLocale(context, 'ar');
              },
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                height: 9.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor == Colors.white
                      ? Color.fromARGB(255, 206, 205, 205)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'العربية',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp),
                    ),
                    translate('ford') == 'فورد'
                        ? Icon(Icons.check, color: Colors.green)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 26.h),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 100.w,
                height: 6.5.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
