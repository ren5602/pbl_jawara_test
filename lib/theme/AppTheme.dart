import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Palet Warna
  static const Color warnaPrimary = Color(0xFF00BFA5); // Tombol utama, header
  static const Color warnaAksen = Color(0xFF808080); // Aksen
  static const Color warnaBackground = Color(0xFFfafafa); // Background
  static const Color warnaTeks = Color(0xFF171d1b); // Teks utama

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // 🌿 Warna latar belakang lembut
    scaffoldBackgroundColor: warnaBackground,

    colorScheme: ColorScheme(
      primary: warnaPrimary,
      onPrimary: Colors.white,
      primaryContainer: warnaAksen,
      onPrimaryContainer: warnaTeks,
      secondary: warnaAksen,
      onSecondary: warnaTeks,
      secondaryContainer: warnaBackground,
      onSecondaryContainer: warnaTeks,
      surface: warnaBackground,
      onSurface: warnaTeks,
      surfaceContainerHighest: warnaAksen.withOpacity(0.2),
      onSurfaceVariant: warnaTeks,
      error: Colors.red.shade700,
      onError: Colors.white,
      errorContainer: Colors.red.shade100,
      onErrorContainer: Colors.red.shade900,
      brightness: Brightness.light,
    ),

    // 🧭 AppBar (header)
    appBarTheme: const AppBarTheme(
      backgroundColor: warnaPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    // 🔘 Tombol utama (CTA)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: warnaPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // 📄 Teks
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: warnaTeks,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: warnaTeks,
      ),
      bodyLarge: TextStyle(fontSize: 16.0, color: warnaTeks),
      bodyMedium: TextStyle(fontSize: 14.0, color: warnaTeks),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: warnaTeks,
      ),
    ),

    // 🔔 Chip, Badge, dan elemen kecil
    chipTheme: ChipThemeData(
      backgroundColor: warnaAksen.withOpacity(0.8),
      labelStyle: const TextStyle(color: warnaTeks),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
