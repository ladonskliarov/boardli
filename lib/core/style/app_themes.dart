import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppThemes {
  static const fontFamily = 'e-Ukraine';
  
  static ThemeData lightTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColors.softLinen,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.gunMetal,
      surface: AppColors.softLinen,
      onSurface: AppColors.gunMetal,
      onPrimary: AppColors.gunMetal,
      secondary: AppColors.gunMetal,
      onSecondary: AppColors.white,
      error: AppColors.softLinen,
      onError: AppColors.tiger,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: fontFamily,
    scaffoldBackgroundColor: AppColors.gunMetal,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.white,
      surface: AppColors.gunMetal,
      onSurface: AppColors.white,
      onPrimary: AppColors.white,
      secondary: AppColors.grey,
      onSecondary: AppColors.white,
      error: AppColors.gunMetal,
      onError: AppColors.tiger,
    ),
 );
}