import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    cardColor: Color(0xff38205A) ,
    accentColor: Color(0xff38205A),
    canvasColor: Color(0xff38205A),
    shadowColor: Color(0xff8E7FC0),
    scaffoldBackgroundColor: Colors.grey.shade900,
    backgroundColor: Color(0xff38205A),
    primaryColor: Colors.black,
    splashColor: Colors.white,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.grey, opacity: 0.8),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff38205A)),
  );

  static final lightTheme = ThemeData(
    cardColor: Color(0xff38205A) ,
    accentColor: Color(0xff675492),
    canvasColor: Colors.white,
    shadowColor: Color(0xff38205A),
    splashColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xff8E7FC0),
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff675492)),
  );
}
