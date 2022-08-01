import 'package:flutter/material.dart';
import 'package:marketplace_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChangeMode extends StatefulWidget {
  @override
  _ChangeModeState createState() => _ChangeModeState();
}

class _ChangeModeState extends State<ChangeMode> {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    int index = Theme.of(context).primaryColor == Colors.black ? 1 : 0;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 38.h,),
            Text(
              'Choose your favourite Theme',
              style: TextStyle(fontSize: 17.sp),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(false);
                  index = 0;
                });
              },
              child: Container(
                height: 9.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor == Colors.white
                      ? Color(0xffF0F0F0)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.asset('assets/icons/china.png',height: 5.h,),
                      //SizedBox(width: 4.w,),
                      Text(
                        'Light',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        index == 0 ? Icons.check : null,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(true);
                  index = 1;
                });
              },
              child: Container(
                height: 9.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image.asset('assets/icons/chile.png',height: 5.h,),
                      //SizedBox(width: 4.w,),
                      Text(
                        'Dark',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      // SizedBox(width: 20.w,),
                      SizedBox(
                        width: 20.w,
                      ),
                      Icon(
                        index == 1 ? Icons.check : null,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.h),
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
