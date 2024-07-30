import 'package:feelhope/components/gradiente_text.dart';
import 'package:flutter/material.dart';

class Logotext extends StatelessWidget {
  const Logotext({super.key});

  @override
  Widget build(BuildContext context) {
    return GradienteText(
      text: "Feel Hope",
      gradient: LinearGradient(
          colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF), Color(0xFF7F7FFF)]),
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}
