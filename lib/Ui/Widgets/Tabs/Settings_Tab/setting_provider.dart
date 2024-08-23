import 'package:flutter/material.dart';

import '../../../../Shared/network/local/cache_helper.dart';

class SettingProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  String lang = "en";

  String get mode => themeMode == ThemeMode.dark ? "dark" : "light";

  bool get isDark => themeMode == ThemeMode.dark;

  String get splashImage =>
      "assets/images/${isDark ? 'bg_splash_dark' : 'bg_splash'}.png";

  Future<void> changeThemeMode(ThemeMode selectedThemeMode) async {
    themeMode = selectedThemeMode;
    await CacheHelper.saveData(key: 'isDark', value: isDark);
    notifyListeners();
  }

  Future<void> changeLanguage(String selectedLanguage) async {
    lang = selectedLanguage;
    await CacheHelper.saveData(key: 'isLanguage', value: lang);
    notifyListeners();
  }
}
