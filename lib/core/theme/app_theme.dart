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
      ),
      // Global Text Theme for Washub
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        bodyLarge: TextStyle(color: Colors.black87),
      ),

    // Production-grade Button Theme (Teal buttons by default)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: washubPrimary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52), // Standard full-width height
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
      ),
      // Corrected Card Theme for Washub
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias, // Important for images in cards
      ),
    );
  }
}