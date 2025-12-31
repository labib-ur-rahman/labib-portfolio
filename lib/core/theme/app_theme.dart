import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.primaryOrange,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange,
        secondary: AppColors.primaryOrangeLight,
        surface: AppColors.backgroundLight,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      // Display - Large Headlines
      displayLarge: GoogleFonts.urbanist(
        fontSize: AppDimensions.fontSizeXXL,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -1.4335,
        height: 1.0,
      ),
      displayMedium: GoogleFonts.urbanist(
        fontSize: AppDimensions.fontSizeXL,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.705,
      ),

      // Headlines
      headlineLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w700,
      ),

      // Body
      bodyLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
      ),

      // Labels
      labelLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w300,
      ),
      labelMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  static TextStyle _lufgaTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    // Using Urbanist as a close alternative to Lufga
    return GoogleFonts.urbanist(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColors.textPrimary,
      letterSpacing: -0.3,
    );
  }
}
