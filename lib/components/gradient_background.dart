import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  GradientBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDarkMode
              ? [Color(0xFF7F7FFF).withOpacity(0.8), Color(0xFF9A4DFF).withOpacity(0.8)]
              : [Color(0xFF7F7FFF).withOpacity(0.5), Color(0xFF9A4DFF).withOpacity(0.5)],
        ),
      ),
      child: child,
    );
  }
}