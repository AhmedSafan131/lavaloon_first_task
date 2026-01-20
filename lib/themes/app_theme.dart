import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';

class AppTheme {
  static ThemeData light(bool centerTitleArabic) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.whiteColor,
      cardColor: AppColors.whiteColor,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.whiteColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: centerTitleArabic,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.whiteColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  static ThemeData dark(bool centerTitleArabic) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      cardColor: AppColors.primaryDark,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        surface: AppColors.primaryDark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: centerTitleArabic,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.primaryDark,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}
