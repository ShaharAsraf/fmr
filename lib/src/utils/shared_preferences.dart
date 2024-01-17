import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kThemeMode = 'theme_mode';

class PrefsUtils {
  const PrefsUtils._();

  static late SharedPreferences _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await _sp.setString(key, value);
  }

  static String? getString(String key) => _sp.getString(key);
  static String getStringOrDefault(String key, String defaultValue) => _sp.getString(key) ?? defaultValue;
}

class Prefs {
  //----------------------getters----------------------
  static String get themeMode => PrefsUtils.getStringOrDefault(kThemeMode, ThemeMode.light.name);

  //----------------------setters----------------------
  static Future<bool> setThemeMode(String value) => PrefsUtils.setString(kThemeMode, value);
}
