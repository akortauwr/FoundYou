import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color backgroundColor = Color(0xFFFFF3D6);
  static const Color primaryColor = Colors.black;
  static const Color secondaryColor = Color(0xFFB1E3FF);
  static const Color accentColor = Color(0xFFFFD6D6);
  static const Color surfaceColor = Colors.white;
  static const Color textColor = Colors.black;

  static ThemeData light() {
    final base = ThemeData.light();
    return base.copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        onPrimary: textColor,
        onSecondary: textColor,
        onSurface: textColor,
      ),
      textTheme: GoogleFonts.archivoTextTheme(base.textTheme.apply(bodyColor: textColor, displayColor: textColor)),
    );
  }
}
