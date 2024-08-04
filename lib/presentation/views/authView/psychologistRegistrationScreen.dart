import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PsychologistRegisterScreen extends StatefulWidget {
  @override
  State<PsychologistRegisterScreen> createState() =>
      _PsychologistRegisterScreenState();
}

class _PsychologistRegisterScreenState
    extends State<PsychologistRegisterScreen> {
  bool _isTermsAccepted = false;
  bool _showPassword = false;

  void _confirmRegistration() {
    _showMessage("Cadastrado com sucesso");
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SingleChildScrollView(
          child: Column(
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
                          : Colors.black54,
                    ),
                  ),
                  Spacer(),
                  ThemeSwitch()
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logotext(),
                    Text(
                      "Crie sua conta - Psicologo",
                      style: TextStyle(
                          fontSize: 16,
                          color: themeNotifier.isDarkMode
                              ? Colors.white54
                              : Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 8),
                      child: GradientTextField(hintText: "Nome"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "Sobrenome"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "E-mail"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(
                        hintText: "Senha",
                        obscureText: _showPassword,
                        suffixButton: IconButton(
                          icon: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "Cpf"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "Telefone"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "Nome da Clínica"),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: GradientTextField(hintText: "CRM"),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: _isTermsAccepted,
                          onChanged: (bool? value) {
                            setState(() {
                              _isTermsAccepted = value ?? false;
                            });
                          },
                        ),
                        Row(
                          children: [
                            Text("Aceito os "),
                            Text(
                              "Termo de uso",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: GradienteButton(
                            text: "Confirmar",
                            onPressed: () {_isTermsAccepted ? _confirmRegistration : null;
                            },
                            width: 130,
                            gradient: LinearGradient(
                                colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                            textColor: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
