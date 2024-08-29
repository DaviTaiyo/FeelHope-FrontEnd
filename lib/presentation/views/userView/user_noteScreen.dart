import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/gradient_iconbutton.dart';

class UserNoteScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  String? selectedFeeling;
  String? selectedIntensity;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30,
                  ),
                  Text(
                    "Voltar",
                    style: TextStyle(
                      color: themeNotifier.isDarkMode
                          ? Colors.white54
                          : Colors.black87,
                    ),
                  ),
                  Spacer(),
                  ThemeSwitch(),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Descreva o que aconteceu...',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: Text('Sentimento'),
                      value: selectedFeeling,
                      items: [
                        'Tristeza',
                        'Felicidade',
                        'Raiva',
                        'Medo',
                        'Ansiedade',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedFeeling = newValue;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      hint: Text('O Quanto sentiu'),
                      value: selectedIntensity,
                      items: [
                        'Baixo',
                        'Moderado',
                        'Alto',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedIntensity = newValue;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GradienteIconButton(
                      icon: Icons.mic,
                      iconSize: 30,
                      onPressed: () {},
                      gradient: LinearGradient(
                          colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      iconColor: Colors.white),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      // Implementar funcionalidade de alerta/socorro
                    },
                    child: Text(
                      'SOCORRO!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  GradienteButton(
                      text: "Enviar",
                      onPressed: () {},
                      gradient: LinearGradient(
                          colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      textColor: Colors.white),
                ],
              ),
              SizedBox(height: 20),
              Text(
                '“Acredite em si mesmo e você será imparável.”',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
