import 'package:flutter/material.dart';

class GradienteIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Gradient gradient;
  final Color iconColor;
  final double? size;
  final double? iconSize;

  const GradienteIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.gradient,
    required this.iconColor,
    this.size,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size ?? 56, // Largura e altura iguais para manter o botão circular
        height: size ?? 56,
        decoration: BoxDecoration(
          gradient: gradient,
          shape: BoxShape.circle, // Define a forma do botão como circular
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize ?? 24,
        ),
      ),
    );
  }
}
