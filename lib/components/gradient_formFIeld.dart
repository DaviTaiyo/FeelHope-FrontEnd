import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? suffixButton;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  GradientFormField({
    required this.label,
    this.obscureText = false,
    this.suffixButton,
    this.inputType = TextInputType.text,
    TextEditingController? controller,
    this.validator,
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
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          labelText: label,
          labelStyle: TextStyle(
            color: themeNotifier.isDarkMode ? Colors.white : Colors.black87,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: suffixButton,
        ),
        style: TextStyle(
          color: themeNotifier.isDarkMode ? Colors.white : Colors.black87,
        ),
        validator: validator,
      ),
    );
  }
}
