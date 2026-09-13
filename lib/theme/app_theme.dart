import 'package:flutter/material.dart';

class AppTheme {
  static const Color darkGreen = Color(0xFF0C3A2B);
  static const Color naturalGreen = Color(0xFF2A7E5C);
  static const Color accentGold = Color(0xFFE5A93C);
  static const Color backgroundIvory = Color(0xFFFFFDF9);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF1C1C1C);
  static const Color textGrey = Color(0xFF666666);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkGreen,
        primary: darkGreen,
        secondary: naturalGreen,
        tertiary: accentGold,
        surface: surfaceCard,
        onSurface: textBlack,
      ),
      scaffoldBackgroundColor: backgroundIvory,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: textBlack,
          fontWeight: FontWeight.w900,
          letterSpacing: -1.5,
          height: 1.1,
        ),
        displayMedium: TextStyle(
          color: textBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.0,
          height: 1.2,
        ),
        headlineLarge: TextStyle(
          color: textBlack,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: textBlack,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(color: textBlack, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(color: textBlack, fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: textGrey, fontSize: 14, height: 1.4),
      ),
      cardTheme: CardThemeData(
        color: surfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: darkGreen, width: 1),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: backgroundIvory,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      ),
    );
  }
}
