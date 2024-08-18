import 'package:flutter/material.dart';
import '../services/dark_theme_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;
  ThemeSharedPrefs themeSharedPrefs = ThemeSharedPrefs();

  set setDarkTheme(bool value) {
    _darkTheme = value;
    themeSharedPrefs.setDarkTheme(value);
    notifyListeners();
  }
}
