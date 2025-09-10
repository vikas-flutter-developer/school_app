import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.secondaryDarker,
      scaffoldBackgroundColor: AppColors.parchment,
      fontFamily: 'Roboto', // Or your preferred font
      appBarTheme: AppBarTheme(
        color: AppColors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.blackHighEmphasis),
        titleTextStyle: const TextStyle(
          color: AppColors.blackHighEmphasis,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.secondaryDarker,
        textTheme: ButtonTextTheme.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondaryDarker,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ash),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.secondaryDarker, width: 2),
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.warningAccent,
      ),
    );
  }
}
