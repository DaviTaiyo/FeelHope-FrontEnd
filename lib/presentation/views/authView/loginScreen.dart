import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/presentation/state/login_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: "");
  bool showPassword = false;

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final loginViewModel = Provider.of<UsuarioLoginViewModel>(context);

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
                      color: themeNotifier.isDarkMode
                          ? Colors.white54
                          : Colors.black54,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50),
                GradientTextField(
                    hintText: "E-mail", controller: _emailController),
                SizedBox(height: 20),
                GradientTextField(
                  hintText: "Senha",
                  controller: _passwordController,
                  obscureText: !showPassword,
                  suffixButton: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                GradienteButton(
                  text: "Login",
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      // Limpa qualquer erro anterior
                      loginViewModel.error = null;
                      await loginViewModel.login(
                        _emailController.text,
                        _passwordController.text,
                      );

                      // Verifica se o login foi bem-sucedido
                      if (loginViewModel.usuario != null) {
                        if (loginViewModel.usuario!.crm != null &&
                            loginViewModel.usuario!.crm!.isNotEmpty) {
                          // Redireciona para a tela do psicólogo
                          Navigator.pushNamed(context, "/homePsico");
                        } else {
                          // Redireciona para a tela do usuário comum
                          Navigator.pushNamed(context, "/home");
                        }
                      } else {
                        // Exibe uma mensagem de erro se o login falhou
                        _showErrorMessage(loginViewModel.error ??
                            "Falha no login. Verifique suas credenciais.");
                      }
                    } else {
                      // Exibe uma mensagem se os campos estiverem vazios
                      _showErrorMessage("Por favor, preencha todos os campos.");
                    }
                  },
                  width: 130,
                  gradient: LinearGradient(
                      colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text("Esqueceu sua senha?",
                          style: TextStyle(color: Colors.purple)),
                      onPressed: () {
                        Navigator.pushNamed(context, "/forgot-password");
                      },
                    ),
                    TextButton(
                      child: Text("Cadastrar-se",
                          style: TextStyle(color: Colors.purple)),
                      onPressed: () {
                        Navigator.pushNamed(context, "/registerUser");
                      },
                    ),
                  ],
                ),
                if (loginViewModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Error: ${loginViewModel.error}',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
