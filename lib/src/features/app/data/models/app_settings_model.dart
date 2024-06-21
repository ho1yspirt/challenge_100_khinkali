// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppSettingsModel extends Equatable {
  const AppSettingsModel({
    required this.currentLocale,
    required this.currentThemeMode,
  });

  final String currentLocale;
  final ThemeMode currentThemeMode;

  AppSettingsModel copyWith({
    String? currentLocale,
    ThemeMode? currentThemeMode,
  }) =>
      AppSettingsModel(
        currentLocale: currentLocale ?? this.currentLocale,
        currentThemeMode: currentThemeMode ?? this.currentThemeMode,
      );

  @override
  List<Object?> get props => [
        currentLocale,
        currentThemeMode,
      ];
}
