import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  Future<bool> getTheme() async {
    final instance = await SharedPreferences.getInstance();
    if (!instance.containsKey("SmartFeedDarkMode"))
      instance.setBool("SmartFeedDarkMode", false);

    bool darkMode = instance.getBool("SmartFeedDarkMode");
    return darkMode;
  }

  Future<void> setTheme(bool darkMode) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setBool("SmartFeedDarkMode", darkMode);
  }
}
