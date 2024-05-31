import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/features/settings/data/datasources/settings_datasource.dart';
import 'package:learn_flutter_aws/src/features/settings/data/models/settings_model.dart';

abstract interface class ISettingsRepository {
  SettingsModel getCurrentSettingsModel();

  Future<void> setCurrentLocale(String locale);

  Future<void> setCurrentThemeMode(ThemeMode themeMode);
}

class SettingsRepository implements ISettingsRepository {
  const SettingsRepository(
    this.settingsDataSource,
  );

  final ISettingsDataSource settingsDataSource;

  @override
  SettingsModel getCurrentSettingsModel() => SettingsModel(
        currentLocale: settingsDataSource.getCurrentLocale(),
        currentThemeMode: settingsDataSource.getCurrentThemeMode(),
      );

  @override
  Future<void> setCurrentLocale(
    String locale,
  ) async =>
      await settingsDataSource.setCurrentLocale(
        locale,
      );

  @override
  Future<void> setCurrentThemeMode(
    ThemeMode themeMode,
  ) async =>
      await settingsDataSource.setCurrentThemeMode(
        themeMode,
      );
}
