import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themeNotifier.dart';

class ThemeSwitch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Row(
                  children: [
                    Icon(themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    Switch(value: themeNotifier.isDarkMode, onChanged: (value) {themeNotifier.toggleTheme();}),
                  ],
                );
  }
}
