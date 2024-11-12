import 'dart:io';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/services/ssl_overrides.dart';
import 'package:feelhope/views/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
        home: Splashscreen(),
      );
    });
  }
}
