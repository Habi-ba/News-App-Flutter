import 'package:flutter/material.dart';
import 'package:news/utils/app_colors.dart';
import 'package:news/utils/app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    cardColor: AppColors.white,
    dividerColor: AppColors.black,
    iconTheme: IconThemeData(color: AppColors.black),
    canvasColor: AppColors.lightGray,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: AppStyles.med20Dark,
    ),
    textTheme: TextTheme(
      headlineSmall: AppStyles.med20Dark,
      titleLarge: AppStyles.med24Dark,
      labelMedium: AppStyles.bold20White,
      labelLarge: AppStyles.bold24Dark,
      bodyMedium: AppStyles.med24Dark,
      bodyLarge: AppStyles.semiBold30White,
      bodySmall: AppStyles.med14Black,
      displayMedium: AppStyles.bold16black,
      displaySmall: AppStyles.med14White,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    cardColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      centerTitle: true,
      titleTextStyle: AppStyles.med20White,
    ),
    dividerColor: AppColors.white,
    iconTheme: IconThemeData(color: AppColors.white),
    canvasColor: AppColors.darkGray,
    textTheme: TextTheme(
      headlineSmall: AppStyles.med20White,
      titleLarge: AppStyles.med24White,
      labelMedium: AppStyles.bold20White,
      labelLarge: AppStyles.bold24Dark,
      bodyMedium: AppStyles.med24White,
      bodyLarge: AppStyles.semiBold30Dark,
      bodySmall: AppStyles.med14White,
      displayMedium: AppStyles.bold16White,
      displaySmall: AppStyles.med14Black,
    ),
  );
}
