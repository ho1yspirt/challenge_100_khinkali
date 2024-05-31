import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ISettingsDataSource {
  String getCurrentLocale();
  Future<void> setCurrentLocale(String locale);
  ThemeMode getCurrentThemeMode();
  Future<void> setCurrentThemeMode(ThemeMode mode);
}

class SettingsDataSource implements ISettingsDataSource {
  const SettingsDataSource(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  static const currentLocaleKey = 'locale';
  static const currentThemeModeKey = 'theme';

  @override
  String getCurrentLocale() {
    return sharedPreferences.getString(currentLocaleKey) ?? 'en';
  }

  @override
  ThemeMode getCurrentThemeMode() {
    return switch (sharedPreferences.getString(currentThemeModeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  @override
  Future<void> setCurrentLocale(String locale) async {
    await sharedPreferences.setString(currentLocaleKey, locale);
  }

  @override
  Future<void> setCurrentThemeMode(ThemeMode themeMode) async {
    late final String theme;

    switch (themeMode) {
      case ThemeMode.light:
        theme = 'light';
      case ThemeMode.dark:
        theme = 'dark';
      default:
        theme = 'system';
    }

    await sharedPreferences.setString(currentThemeModeKey, theme);
  }
}
