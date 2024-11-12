import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserNoteScreen extends StatefulWidget {
  @override
  _UserNoteScreenState createState() => _UserNoteScreenState();
}

class _UserNoteScreenState extends State<UserNoteScreen> {
  final TextEditingController _textController = TextEditingController();
  String? selectedFeeling;
  String? selectedIntensity;
  final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  final List<String> intensidades = ['Baixo', 'Moderado', 'Alto'];
  final List<String> sentimentos = [
    'Tristeza',
    'Felicidade',
    'Raiva',
    'Medo',
    'Ansiedade'
  ];

  void _submitReport() {
    if (selectedFeeling != null && selectedIntensity != null && _textController.text.isNotEmpty) {
      Navigator.pop(context, {
        "title": "Relatório de $selectedFeeling",
        "date": formattedDate,
        "description": _textController.text,
        "intensity": selectedIntensity
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Relatório"),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formattedDate,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _textController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Descreva o que aconteceu...',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: OutlineInputBorder()),
                        hint: Text('Sentimento'),
                        value: selectedFeeling,
                        items: sentimentos.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedFeeling = newValue;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: OutlineInputBorder()),
                        hint: Text('Intensidade'),
                        value: selectedIntensity,
                        items: intensidades.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedIntensity = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GradienteButton(
                  text: "Enviar",
                  onPressed: _submitReport,
                  gradient: LinearGradient(
                      colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
