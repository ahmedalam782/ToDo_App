import 'package:flutter/material.dart';

import '../../../../Shared/network/local/cache_helper.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode themeMode = CacheHelper.getData(key: 'isDark') == null
      ? ThemeMode.light
      : CacheHelper.getData(key: 'isDark')
          ? ThemeMode.dark
          : ThemeMode.light;

  String lang = CacheHelper.getData(key: 'isLanguage') ?? "en";

  String get mode => themeMode == ThemeMode.dark ? "dark" : "light";

  bool get isDark => themeMode == ThemeMode.dark;

  String get splashImage =>
      "assets/images/${isDark ? 'bg_splash_dark' : 'bg_splash'}.png";

  void changeThemeMode(ThemeMode selectedThemeMode) {
    themeMode = selectedThemeMode;
    CacheHelper.saveData(key: 'isDark', value: isDark);
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    lang = selectedLanguage;
    CacheHelper.saveData(key: 'isLanguage', value: lang);
    notifyListeners();
  }
}
