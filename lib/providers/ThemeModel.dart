import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModel with ChangeNotifier {
  SharedPreferences _sharedPreferences;
  static ThemeModel _instance;
  static bool _isDark = false;
  ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color(0xFF16213E),
    scaffoldBackgroundColor: Color(0xAA1A1A2E),
    cardColor: Color(0x110F3460),
    textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white))
  );
  ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[100],
  );

  ThemeModel.primary() {
    _readTheme();
  }

  factory ThemeModel() {
    if (_instance == null) _instance = ThemeModel.primary();
    return _instance;
  }

  ThemeData currentTheme() {
    return _isDark ? darkTheme : lightTheme;
  }

  Icon getIcon() {
    return Icon(_isDark ? Icons.brightness_3 : Icons.brightness_high);
  }

  void switchTheme() {
    _isDark = !_isDark;
    _writeTheme(_isDark);
    notifyListeners();
  }

  void _readTheme() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isDark = _sharedPreferences.getBool("isDark") ?? false;
    notifyListeners();
  }

  void _writeTheme(bool isDark) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences.setBool("isDark", isDark);
  }
}
