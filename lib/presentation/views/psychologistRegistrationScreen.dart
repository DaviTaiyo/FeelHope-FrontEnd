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
        body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 35, 16, 16),
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
                  SizedBox(height: 16),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nome",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Senha",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
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
                        )),
                    obscureText: !_showPassword,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "CPF",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nome da clínica",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "CRM",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
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
                          Text("Termo de uso", style: TextStyle(color: Colors.blue),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isTermsAccepted ? _confirmRegistration : null,
                    child: Text("Confirmar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
