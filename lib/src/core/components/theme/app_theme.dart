import 'package:flutter/material.dart';
import 'package:learn_flutter_aws/src/core/constants/constants.dart';

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
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColors.primary,
    ),
  );

  late final ThemeData darkThemeData = _baseThemeData.copyWith(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColors.primary,
    ),
  );
}
