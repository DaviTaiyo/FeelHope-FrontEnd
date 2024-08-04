import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool isCodeSent = false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Logotext(),
              Text(
                "Esqueci a senha...",
                style: TextStyle(
                    fontSize: 16,
                    color: themeNotifier.isDarkMode
                        ? Colors.white54
                        : Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                "Redefinir Senha",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 20),
              GradientTextField(hintText: "E-mail", controller: _emailController,),
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () {
                      setState(() {
                        isCodeSent = true;
                      });
                    },
                    child: Text("Enviar"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (isCodeSent)
                Text(
                  "Um código foi enviado para seu email!",
                  style: TextStyle(color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
