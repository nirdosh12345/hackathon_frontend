import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Cyber Guardian Colors
  static const Color primaryColor = Color(0xFF00E676);
  static const Color secondaryColor = Color(0xFF00BCD4);
  static const Color scaffoldColor = Color(0xFF0D1117);
  static const Color cardColor = Color(0xFF161B22);
  static const Color errorColor = Color(0xFFFF5252);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: scaffoldColor,

    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: scaffoldColor,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),

    cardTheme: CardThemeData(
      color: cardColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryColor,
  );
}