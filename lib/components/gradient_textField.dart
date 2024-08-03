import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? suffixButton;

  GradientTextField({
    required this.hintText,
    this.obscureText = false,
    this.suffixButton,
    TextEditingController? controller,
  }) : controller = controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Color(0xFF7F7FFF).withOpacity(0.5),
            Color(0xFF9A4DFF).withOpacity(0.5),
            Color(0xFF7F7FFF).withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          labelText: hintText,
          labelStyle: TextStyle(color: themeNotifier.isDarkMode? Colors.white : Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixButton,
        ),
        style: TextStyle(color: themeNotifier.isDarkMode? Colors.white : Colors.black87),
      ),
    );
  }
}

//finalizar posteriormente