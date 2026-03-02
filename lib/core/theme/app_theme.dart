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
      textTheme: _lightTextTheme,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.surfaceDark,
      primaryColor: AppColors.primaryOrange,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryOrange,
        secondary: AppColors.primaryOrangeLight,
        surface: AppColors.surfaceDark,
        onPrimary: AppColors.textWhite,
        onSecondary: AppColors.textDarkPrimary,
        onSurface: AppColors.textDarkPrimary,
        surfaceContainerHighest: AppColors.cardDarkElevated,
      ),
      textTheme: _darkTextTheme,
    );
  }

  static TextTheme get _lightTextTheme {
    return TextTheme(
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
      headlineLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      headlineMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      bodyLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      labelLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w300,
        color: AppColors.textPrimary,
      ),
      labelMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: GoogleFonts.urbanist(
        fontSize: AppDimensions.fontSizeXXL,
        fontWeight: FontWeight.w600,
        color: AppColors.textDarkPrimary,
        letterSpacing: -1.4335,
        height: 1.0,
      ),
      displayMedium: GoogleFonts.urbanist(
        fontSize: AppDimensions.fontSizeXL,
        fontWeight: FontWeight.w700,
        color: AppColors.textDarkPrimary,
        letterSpacing: -0.705,
      ),
      headlineLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w500,
        color: AppColors.textDarkPrimary,
      ),
      headlineMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w700,
        color: AppColors.textDarkPrimary,
      ),
      bodyLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w500,
        color: AppColors.textDarkPrimary,
      ),
      bodyMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
        color: AppColors.textDarkPrimary,
      ),
      labelLarge: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeL,
        fontWeight: FontWeight.w300,
        color: AppColors.textDarkPrimary,
      ),
      labelMedium: _lufgaTextStyle(
        fontSize: AppDimensions.fontSizeM,
        fontWeight: FontWeight.w400,
        color: AppColors.textDarkPrimary,
      ),
    );
  }

  static TextStyle _lufgaTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
  }) {
    return GoogleFonts.urbanist(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: -0.3,
    );
  }
}
