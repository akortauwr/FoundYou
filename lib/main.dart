import 'package:flutter/material.dart';
import 'package:found_you_app/routing/router.dart';
import 'package:found_you_app/ui/core/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = AppTheme.light();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(theme: theme, themeMode: ThemeMode.system, routerConfig: router(context.read()));
  }
}
