import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/common/app_constants.dart';

class ThemeController with ChangeNotifier {
  final SharedPreferences sharedPreferences;

  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    sharedPreferences.setBool(AppConstants.theme, _isDarkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() {
    _isDarkTheme =
        sharedPreferences.getBool(AppConstants.theme) ?? false;
  }
}
