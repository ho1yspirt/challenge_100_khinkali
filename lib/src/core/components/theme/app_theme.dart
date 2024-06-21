import 'package:flutter/material.dart';
import '../../constants/constants.dart';

final class AppTheme {
  final ThemeData _baseThemeData = ThemeData(
    primaryColor: AppColors.primary,
    fontFamily: AppFonts.inter,
    textTheme: const TextTheme(),
    inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  late final ThemeData lightThemeData = _baseThemeData.copyWith(
    colorScheme: const ColorScheme.highContrastLight(
      surfaceTint: Colors.transparent,
      brightness: Brightness.light,
      primary: AppColors.primary,
    ),
  );

  late final ThemeData darkThemeData = _baseThemeData.copyWith(
    colorScheme: const ColorScheme.highContrastDark(
      surfaceTint: Colors.transparent,
      brightness: Brightness.dark,
      primary: AppColors.primary,
    ),
  );
}
