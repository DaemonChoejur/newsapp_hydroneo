import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app_hydroneo/constants.dart';
import 'package:news_app_hydroneo/repository/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  // custom dark theme
  final darkTheme = ThemeData(
    fontFamily: 'Proxima Nova',
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    brightness: Brightness.dark,
  );

  // custom light theme
  final lightTheme = ThemeData(
    fontFamily: 'Proxima Nova',
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    brightness: Brightness.light,
  );

  // initialize _themeData
  ThemeData _themeData = ThemeData();

  // getter for themedata
  ThemeData getTheme() => _themeData;

  bool isDarkMode = false;

  ThemeNotifier() {
    // reading value of themeMode from shared preferences
    StorageManager.readData('themeMode').then((value) {
      debugPrint('Reading value from storage: $value');
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        debugPrint("Setting light theme");
        _themeData = lightTheme;
        isDarkMode = false;
      } else {
        debugPrint("Setting dark theme");
        _themeData = darkTheme;
        isDarkMode = true;
      }
      // notify all listeners after reading and setting theme
      notifyListeners();
    });
  }

  void setDarkMode() async {
    // set current theme to darkTheme
    _themeData = darkTheme;
    // save the current them in shared preferences
    StorageManager.saveData(kThemeMode, kDark);
    isDarkMode = true;
    // update listeners
    notifyListeners();
  }

  void setLightMode() async {
    // set current theme to lightTheme
    _themeData = lightTheme;
    // save the current them in shared preferences
    StorageManager.saveData(kThemeMode, kLight);
    isDarkMode = false;
    // listeners
    notifyListeners();
  }
}
