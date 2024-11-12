import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/presentation/views/authView/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
      return MaterialApp(
        title: 'FeelHope App',
        theme: themeNotifier.currentTheme,
        home: Loginscreen(),
      );
    });
  }
}
