import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:json_theme/json_theme.dart';

enum ThemeType { lightTheme, darkTheme }

abstract class ThemeRepository {
  static Future<ThemeData> loadTheme(ThemeType type) async {
    final String assetPath = _getAssetPath(type);
    final String themeStr = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> themeJson = jsonDecode(themeStr);

    final ThemeData? theme = ThemeDecoder.decodeThemeData(themeJson);
    if (theme == null) {
      throw Exception('Błąd dekodowania danych motywu');
    }
    return theme;
  }

  static String _getAssetPath(ThemeType type) {
    switch (type) {
      case ThemeType.lightTheme:
        return 'assets/app_theme/theme_light.json';
      case ThemeType.darkTheme:
        return 'assets/app_theme/theme_dark.json';
    }
  }
}
