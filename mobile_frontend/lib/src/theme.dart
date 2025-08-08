import 'package:flutter/material.dart';

class AppTheme {
  // Colors based on requirements
  static const Color primaryColor = Color(0xFFFFA500); // Orange
  static const Color accentColor = Color(0xFFFF4500); // OrangeRed
  static const Color backgroundColor = Color(0xFFFFFFFF); // White
  static const Color navBarBackground = Color(0xFFF9F9F9); // Slightly off-white

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: backgroundColor,
          surface: backgroundColor,
          onPrimary: Colors.white,
          onSurface: Colors.black87,
          onSecondary: Colors.black,
          error: Colors.red,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        cardTheme: CardTheme(
          color: backgroundColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: navBarBackground,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF6F6F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: accentColor),
        ),
      );
}
