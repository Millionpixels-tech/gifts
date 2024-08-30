import 'package:flutter/material.dart';
import 'package:gifts/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appLightTheme = ThemeData.light().copyWith(
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: LightThemeAppColors.primaryColor,
      onPrimary: LightThemeAppColors.onPrimary,
      secondary: LightThemeAppColors.secondaryColor,
      onPrimaryFixed: LightThemeAppColors.onPrimaryFixed,
      error: LightThemeAppColors.errorColor,
      onError: LightThemeAppColors.onErrorColor,
      surface: LightThemeAppColors.surfaceColor,
      onSurface: LightThemeAppColors.onSurfaceColor,
      tertiary: LightThemeAppColors.tertiaryColor,
      onTertiary: LightThemeAppColors.onTertiaryColor,
      outline: LightThemeAppColors.outlineColor,
      outlineVariant: LightThemeAppColors.outlineVariantColor,
      onSecondary: LightThemeAppColors.onSecondaryColor,
      onSurfaceVariant: LightThemeAppColors.surfaceVariantColor,
      onTertiaryFixedVariant: LightThemeAppColors.tertiaryVariantColor),
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.k2dTextTheme(
    ThemeData.light().textTheme,
  ).copyWith(
    titleLarge: AppTextStyles.tittleLarge,
    titleMedium: AppTextStyles.tittleMedium,
    titleSmall: AppTextStyles.tittleSmall,
    headlineMedium: AppTextStyles.headlineMedium,
    headlineSmall: AppTextStyles.headlineSmall,
    headlineLarge: AppTextStyles.headlineLarge,
    labelLarge: AppTextStyles.labelLarge,
    labelMedium: AppTextStyles.labelMedium,
    bodyLarge: AppTextStyles.bodyLarge,
    bodyMedium: AppTextStyles.bodyMedium,
    bodySmall: AppTextStyles.bodySmall,
  ),
);