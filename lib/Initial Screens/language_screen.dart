import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/Initial%20Screens/theme_screen.dart';
import 'package:sizer/sizer.dart';

class LanguageScreen extends StatefulWidget {
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int langIndex;
  bool isEnglish = translate('ford') == 'Ford' ? true : false;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor == Colors.white
        ? Colors.black
        : Colors.white;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/icons/logo.png',
                color: color,
                height: 10.h,
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please choose the language',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 2.h),
              CircleAvatar(
                radius: 9.7.h,
                backgroundColor: langIndex == 1
                    ? Theme.of(context).shadowColor
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      changeLocale(context, 'en');
                      langIndex = 1;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor == Colors.white
                            ? Color(0xffF0F0F0)
                            : Colors.white,
                    radius: 9.h,
                    child: Text(
                      'English',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الرجاء اختيار لغة التطبيق',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 1.h),
              CircleAvatar(
                radius: 9.7.h,
                backgroundColor: langIndex == 2
                    ? Theme.of(context).shadowColor
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      changeLocale(context, 'ar');
                      langIndex = 2;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor == Colors.white
                            ? Color(0xffF0F0F0)
                            : Colors.white,
                    radius: 9.h,
                    child: Text(
                      'العربية',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => ThemeScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 30.w,
                  height: 5.h,
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
              ),
              SizedBox(height: 3.h)
            ],
          ),
        ),
      ),
    );
  }
}
