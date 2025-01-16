import 'package:flutter/material.dart';

import '../utils/responsive.dart';

class AppTheme {
  static const purple = Color(0xFF7d07bd);
  static const deepBlue = Color(0xFF0085ff);
  static const blue = Color(0xFF0099ff);
  static const lightBlue = Color(0xFF18c3ff);
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Inter',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        primary: purple,
        secondary: deepBlue,
        seedColor: blue,
        background: Colors.blueGrey[100],
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 57),
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
        ),
        displayMedium: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 45),
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
        ),
        displaySmall: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 36),
          fontWeight: FontWeight.bold,
          letterSpacing: -0.25,
        ),
        headlineLarge: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 32),
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        headlineMedium: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 28),
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        headlineSmall: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 24),
          fontWeight: FontWeight.w600,
          letterSpacing: -0.25,
        ),
        titleLarge: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 22),
          fontWeight: FontWeight.w500,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 16),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 14),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 16),
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 14),
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 12),
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 14),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 12),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: ResponsiveConfig.getFontSize(context, 11),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            surfaceTintColor: MaterialStatePropertyAll(deepBlue),
            foregroundColor: MaterialStatePropertyAll(deepBlue),
            overlayColor: MaterialStatePropertyAll(lightBlue.withOpacity(.1))),
      ),
      cardTheme: CardTheme(elevation: 2, color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveConfig.getFontSize(context, 16),
            vertical: ResponsiveConfig.getFontSize(context, 8),
          ),
        ),
      ),
    );
  }
}
