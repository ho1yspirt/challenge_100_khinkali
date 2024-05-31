// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsModel extends Equatable {
  const SettingsModel({
    required this.currentLocale,
    required this.currentThemeMode,
  });

  final String currentLocale;
  final ThemeMode currentThemeMode;

  SettingsModel copyWith({
    String? currentLocale,
    ThemeMode? currentThemeMode,
  }) =>
      SettingsModel(
        currentLocale: currentLocale ?? this.currentLocale,
        currentThemeMode: currentThemeMode ?? this.currentThemeMode,
      );

  @override
  List<Object?> get props => [
        currentLocale,
        currentThemeMode,
      ];
}
