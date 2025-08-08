import 'package:flutter/material.dart';

class AppTheme {
  // Color definitions for a vibrant orange theme
  static const Color primaryColor = Color(0xFFFFA500); // Orange
  static const Color accentColor = Color(0xFFFFA500); // Now also Orange for consistency
  static const Color backgroundColor = Color(0xFFFFFFFF); // White
  static const Color navBarBackground = Color(0xFFF9F9F9); // Slightly off-white

  static ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: primaryColor, // Use orange as secondary/accent
          surface: backgroundColor,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black87,
          error: Colors.red,
        ),
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          foregroundColor: primaryColor,
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFA500),
            fontWeight: FontWeight.w700,
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            side: const BorderSide(color: primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF6F6F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          labelStyle: const TextStyle(color: primaryColor),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: primaryColor,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(primaryColor),
          trackColor: MaterialStateProperty.all(primaryColor.withOpacity(0.55)),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(primaryColor),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(primaryColor),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: primaryColor,
          thumbColor: primaryColor,
          inactiveTrackColor: primaryColor.withOpacity(0.4),
        ),
      );
}
