import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightThemeAppColors {
  static const Color primaryColor = Color(0xffE62B60);
  static const Color secondaryColor = Color(0xff1877F2);
  static const Color onPrimaryFixed = Color(0xffFFFFFF);
  static const Color onPrimary = Color(0xff282828);
  static const Color surfaceColor = Color(0xffF7F7FB);
  static const Color surfaceVariantColor = Color(0xffFFF1FC);
  static const Color onSurfaceColor = Color(0xff2929B6);
  static const Color tertiaryColor = Color(0xff666691);
  static const Color tertiaryVariantColor = Color(0xffF4F5F7);
  static const Color onTertiaryColor = Color(0xffB2B2C8);
  static const Color outlineColor = Color(0xff9AC5FD);
  static const Color onSecondaryColor = Color(0xffF0F6FF);
  static const Color outlineVariantColor = Color(0xff00C7BE);
  static const Color errorColor = Color(0xffF64242);
  static const Color onErrorColor = Color(0xffF00000);
  static const Color mainBlack = Color(0xff000000);
  static const Color starColour = Color(0xffFFC700);
}

class AppFontSizes {
  static double themeFontSize12 = 12.0;
  static double themeFontSize14 = 14.0;
  static double themeFontSize16 = 16.0;
  static double themeFontSize18 = 18.0;
}

class AppFontWeights {
  static FontWeight themeFontWeightLight = FontWeight.w300;
  static FontWeight themeFontWeightRegular = FontWeight.w400;
  static FontWeight themeFontWeightMedium = FontWeight.w500;
}

class AppTextStyles {
  static TextStyle headlineLarge = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightMedium,
      fontSize: 22,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle headlineMedium = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightRegular,
      fontSize: 18,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle headlineSmall = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightMedium,
      fontSize: 18,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle tittleLarge = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightMedium,
      fontSize: 16,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle tittleMedium = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightRegular,
      fontSize: 16,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle tittleSmall = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightMedium,
      fontSize: 14,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle labelMedium = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightMedium,
      fontSize: 12,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle bodyLarge = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightLight,
      fontSize: 14,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle labelLarge = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightRegular,
      fontSize: 14,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle bodyMedium = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightRegular,
      fontSize: 12,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
  static TextStyle bodySmall = GoogleFonts.poppins(
    textStyle: TextStyle(
      fontWeight: AppFontWeights.themeFontWeightLight,
      fontSize: 12,
      color: LightThemeAppColors.onPrimary,
      height: 1.4,
      letterSpacing: 0,
    ),
  );
}
