import 'package:flutter/material.dart';

class GradienteButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;
  final Color textColor;
  final double? width;
  final double? height;
  final double? textSize;

  const GradienteButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.gradient,
    required this.textColor,
    this.height,
    this.width,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width ?? 24, vertical: height ?? 12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: textSize ?? 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}