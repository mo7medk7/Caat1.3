import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  //data
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  final SharedPreferences _prefs;
  final SharedPreferences _prefsTheme;

  AppConfigProvider(this._prefs, this._prefsTheme) {
    var selectedLanguage = _prefs.getString("selectedLocale");
    var selectedTheme = _prefsTheme.getString("selectedTheme");
    if (selectedLanguage != null) {
      appLanguage = selectedLanguage;
    }
    if (selectedTheme != null && selectedTheme == "light") {
      appTheme = ThemeMode.light;
    } else if (selectedTheme != null && selectedTheme == "dark") {
      appTheme = ThemeMode.dark;
    }
  }

  String get locale => appLanguage;

  ThemeMode get themeMode => appTheme;

  void changeLanguage(String newlanguage) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    appLanguage = newlanguage;
    _prefs.setString("selectedLocale", newlanguage);
    notifyListeners();
  }

  void changeTheme(String newMode) async {
    SharedPreferences _prefsTheme = await SharedPreferences.getInstance();
    if (newMode == 'dark') {
      appTheme = ThemeMode.dark;
      _prefsTheme.setString("selectedTheme", "dark");
    } else if (newMode == 'light') {
      appTheme = ThemeMode.light;
      _prefsTheme.setString("selectedTheme", "light");
    }
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
