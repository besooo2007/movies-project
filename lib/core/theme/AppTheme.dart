import 'AppColors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    return ThemeData(
      primaryColor: AppColors.background,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
          fontFamily: "Roboto",
        ),
        bodyMedium: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
          fontFamily: "Roboto",
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.textColor,
          fontFamily: "Roboto",
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.textColor,
          fontFamily: "Roboto",
        ),
        displaySmall: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.textColor,
          fontFamily: "Roboto",
        ),
      ),
    );
  }
}
