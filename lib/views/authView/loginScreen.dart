import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/authView/forgotPasswordScreen.dart';
import 'package:feelhope/views/authView/userRegistrationScreen.dart';
import 'package:feelhope/views/psychoView/homePagePsyScreen.dart';
import 'package:feelhope/views/userView/user_homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UsuarioService _usuarioService = UsuarioService();
  bool showPassword = false;

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

  Future<void> _logarUsuario() async {
    final resultado = await _usuarioService.login(_emailController.text, _passwordController.text);

    if (resultado != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', resultado.token!);
      if (resultado.crm != null) {
        _showMessage("Profissional Logado");
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePagePsyco()));
      } else {
        _showMessage("Usuario Logado");
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomepage()));
      }
    } else {
      _showMessage("Erro ao efetuar Login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    ThemeSwitch(),
                  ],
                ),
                Logotext(),
                Text(
                  "Bem-vindo ao FeelHope",
                  style: TextStyle(
                      fontSize: 16,
                      color: themeNotifier.isDarkMode ? Colors.white54 : Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                GradientTextField(hintText: "E-mail", controller: _emailController),
                SizedBox(height: 20),
                GradientTextField(
                  hintText: "Senha",
                  controller: _passwordController,
                  obscureText: !showPassword,
                  suffixButton: IconButton(
                    icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 50),
                GradienteButton(
                  text: "Login",
                  onPressed: () {
                    _logarUsuario();
                  },
                  width: 130,
                  gradient: LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text("Esqueceu sua senha?", style: TextStyle(color: Colors.purple)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                      },
                    ),
                    TextButton(
                      child: Text("Cadastrar-se", style: TextStyle(color: Colors.purple)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistrationScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
