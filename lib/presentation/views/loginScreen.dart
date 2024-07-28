import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/gradiente_text.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/presentation/views/forgotPasswordScreen.dart';
import 'package:feelhope/presentation/views/homePagePsyScreen.dart';
import 'package:feelhope/presentation/views/userRegistrationScreen.dart';
import 'package:flutter/material.dart';
import '../state/login_state.dart';
import 'package:provider/provider.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    Spacer(),
                    Icon(themeNotifier.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    Switch(value: themeNotifier.isDarkMode, onChanged: (value) {themeNotifier.toggleTheme();}),
                  ],
                ),
                SizedBox(
                    height: 40,
                  ),
                  GradienteText(
                    text: "Feel Hope",
                    gradient: LinearGradient(
                        colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF), Color(0xFF7F7FFF)]),
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text("Vai se tratar main yasuo dos infernos", style: TextStyle(fontSize: 16, color: themeNotifier.isDarkMode ? Colors.white54 : Colors.black54, fontWeight: FontWeight.bold),),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passwordController,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (bool? value) {},
                          ),
                          Text("Continue Conectado"),
                        ],
                      ),
                      SizedBox(height: 20),
                      GradienteButton(
                        text: "Login",
                        onPressed: () {
                          final loginState =
                              Provider.of<LoginState>(context, listen: false);
                          loginState.login(
                              _usernameController.text, _passwordController.text);
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                              );
                            },
                          ),
                          TextButton(
                            child: Text("Cadastrar-se",
                                style: TextStyle(color: Colors.purple)),
                            onPressed: () {Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => UserRegistrationScreen() //se quiser ver a pagina inicial, <= MUDE PARA HOMEPAGE()
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Consumer<LoginState>(builder: (context, state, child) {
                        if (state.user != null) {
                          return Text(
                            "Logged in as: ${state.user!.username}!",
                            style: TextStyle(color: Colors.white),
                          );
                        } else if (state.error != null) {
                          return Text(
                            "Error: ${state.error}",
                            style: TextStyle(color: Colors.white),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ]),
              ],
            )),
      ),
    );
  }
}
