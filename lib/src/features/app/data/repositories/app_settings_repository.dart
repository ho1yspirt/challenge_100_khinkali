import 'package:flutter/material.dart';
import '../datasources/app_settings_datasource.dart';
import '../models/app_settings_model.dart';

abstract interface class AppSettingsRepository {
  AppSettingsModel getCurrentSettingsModel();

  Future<void> setCurrentLocale(String locale);

  Future<void> setCurrentThemeMode(ThemeMode themeMode);
}

class AppSettingsRepository$Impl implements AppSettingsRepository {
  const AppSettingsRepository$Impl(
    this.appSettingsDataSource,
  );

  final AppSettingsDataSource appSettingsDataSource;

  @override
  AppSettingsModel getCurrentSettingsModel() => AppSettingsModel(
        currentLocale: appSettingsDataSource.getCurrentLocale(),
        currentThemeMode: appSettingsDataSource.getCurrentThemeMode(),
      );

  @override
  Future<void> setCurrentLocale(
    String locale,
  ) async =>
      await appSettingsDataSource.setCurrentLocale(
        locale,
      );

  @override
  Future<void> setCurrentThemeMode(
    ThemeMode themeMode,
  ) async =>
      await appSettingsDataSource.setCurrentThemeMode(
        themeMode,
      );
}
