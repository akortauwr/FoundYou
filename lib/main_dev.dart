import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:found_you_app/config/providers.dart';
import 'package:found_you_app/data/repositories/theme/theme.dart';
import 'package:found_you_app/data/repositories/theme/theme_repository.dart';
import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

import 'main.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await ThemeRepository.loadTheme(ThemeType.lightTheme);
  final darkTheme = await ThemeRepository.loadTheme(ThemeType.darkTheme);
  final appTheme = AppTheme;
  runApp(MultiProvider(providers: providersRemote, child: MyApp(theme: AppTheme.light(), darkTheme: darkTheme,)));
}