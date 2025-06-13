import 'package:flutter/material.dart';
import 'package:found_you_app/config/providers.dart';
import 'package:provider/provider.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: providersRemote, child: MyApp()));
}
