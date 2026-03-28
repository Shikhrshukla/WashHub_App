import 'package:flutter/material.dart';// Washub Brand Colors
const Color washubPrimary      = Color(0xFF1A7A6A); // Teal
const Color washubPrimaryLight = Color(0xFFAFEEE7); // Soft Teal Bg
const Color washubAmber        = Color(0xFFF5A623); // Rating Badge
const Color washubBlue         = Color(0xFF2563EB); // Promo/Verified
const Color washubBg           = Color(0xFFF0F7F6); // App Background
const Color washubRed          = Color(0xFFDC2626); // Logout/Errors

class WashubTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: washubPrimary,
      scaffoldBackgroundColor: washubBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: washubPrimary,
        primary: washubPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),

      // Global Text Theme
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        bodyLarge: TextStyle(color: Colors.black87),
      ),

      // Global Input Decoration (For Search and Forms)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: washubPrimary, width: 1.5),
        ),
      ),

      // Production-grade Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: washubPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: washubPrimary,
          side: const BorderSide(color: washubPrimary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size(double.infinity, 52),
        ),
      ),

      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}