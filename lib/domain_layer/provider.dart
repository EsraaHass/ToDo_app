import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  String currentLanguage = 'en';

  bool isDark() => currentTheme == ThemeMode.dark;

  bool isEnglish() => currentLanguage == 'en';

  changeLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    if (lang == currentLanguage) return;
    currentLanguage = lang;
    prefs.setString('lang', currentLanguage);
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) async {
    final prefs = await SharedPreferences.getInstance();
    if (newTheme == currentTheme) return;
    currentTheme = newTheme;
    prefs.setString(
        'theme', currentTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }
}
