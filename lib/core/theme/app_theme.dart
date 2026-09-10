import 'package:flutter/material.dart';
import '../constants/asset_constants.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
    ),

    colorScheme: const ColorScheme.dark(
      primary: AppColors.cyan,
      secondary: AppColors.purple,
      surface: AppColors.cardBackground,
    ),
  );
}