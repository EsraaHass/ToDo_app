import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  String currentLanguage = 'en';

  bool isDark() => currentTheme == ThemeMode.dark;

  bool isEnglish() => currentLanguage == 'en';

  changeLang(String lang) {
    if (lang == currentLanguage) return;
    currentLanguage = lang;
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) {
    if (newTheme == currentTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }
}
