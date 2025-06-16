import 'package:flutter/material.dart';
import 'package:found_you_app/routing/router.dart';
import 'package:found_you_app/ui/core/theme/theme.dart';
import 'package:provider/provider.dart';

import 'config/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: providersRemote, child: MyApp()));
}

class MyApp extends StatelessWidget {
  final ThemeData theme = AppTheme.light();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      themeMode: ThemeMode.system,
      routerConfig: router(context.read()),
    );
  }
}
