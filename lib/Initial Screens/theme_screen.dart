import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/login.dart';
import 'package:marketplace_app/pages/city_screen.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeMode themeMode = ThemeMode.system;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkt =
        Theme.of(context).primaryColor == Colors.black ? true : false;
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Image.asset(
                'assets/icons/logo.png',
                color: Theme.of(context).splashColor,
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translate('asktheme'),
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: CircleAvatar(
                      radius: 9.7.h,
                      backgroundColor: isDarkt
                          ? Theme.of(context).shadowColor
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            final provider = Provider.of<ThemeProvider>(context,
                                listen: false);
                            provider.toggleTheme(true);
                            isDarkt = true;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[800],
                          radius: 9.h,
                          child: Text(
                            translate('dark'),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: CircleAvatar(
                      radius: 9.7.h,
                      backgroundColor: !isDarkt
                          ? Theme.of(context).shadowColor
                          : Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            final provider = Provider.of<ThemeProvider>(context,
                                listen: false);
                            provider.toggleTheme(false);
                            isDarkt = false;
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 206, 205, 205),
                          radius: 9.h,
                          child: Text(
                            translate('light'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Login()));
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
                    translate('continue'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ),
        ),
      ),
    );
  }
}
