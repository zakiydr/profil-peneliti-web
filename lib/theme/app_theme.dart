import 'package:flutter/material.dart';
import 'package:profile_peneliti/theme/app_colors.dart';

import '../utils/responsive.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Inter',
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        // primary: purple,
        // secondary: deepBlue,
        seedColor: Colors.blue,
        surface: Colors.white,
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
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            surfaceTintColor: WidgetStatePropertyAll(AppColors.deepBlue),
            foregroundColor: WidgetStatePropertyAll(AppColors.deepBlue),
            overlayColor:
                WidgetStatePropertyAll(Color.fromARGB(255, 175, 234, 255))),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: AppColors.lightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
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
