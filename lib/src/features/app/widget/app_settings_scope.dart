import 'package:flutter/material.dart';

import '../data/models/app_settings_model.dart';

class AppSettingsScope extends InheritedWidget {
  const AppSettingsScope({
    super.key,
    required this.appSettingsModel,
    required super.child,
  });

  final AppSettingsModel appSettingsModel;

  static AppSettingsModel? maybeOf(BuildContext context) {
    return (context.getElementForInheritedWidgetOfExactType<AppSettingsScope>()?.widget as AppSettingsScope?)
        ?.appSettingsModel;
  }

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError('Out of scope');

  static AppSettingsModel of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(AppSettingsScope oldWidget) => appSettingsModel != oldWidget.appSettingsModel;
}
