import 'package:flutter/material.dart';
import 'package:found_you_app/data/repositories/theme/theme_repository.dart';
import 'package:found_you_app/routing/router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final theme = await ThemeRepository.loadTheme(ThemeType.lightTheme);
  final darkTheme = await ThemeRepository.loadTheme(ThemeType.darkTheme);

  runApp(MyApp(theme: theme, darkTheme: darkTheme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({super.key, required this.theme, required this.darkTheme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      theme: theme,
      darkTheme: darkTheme,
      routerConfig: router(context.read()),
    );
  }
}
