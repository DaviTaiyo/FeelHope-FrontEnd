import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/presentation/views/authView/forgotPasswordScreen.dart';
import 'package:feelhope/presentation/views/authView/userRegistrationScreen.dart';
import 'package:feelhope/presentation/views/userView/user_homePage.dart';
import 'package:flutter/material.dart';
import '../../state/login_state.dart';
import 'package:provider/provider.dart';
import 'package:feelhope/presentation/views/psychoView/homePagePsyScreen.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final _usernameController = TextEditingController();
  //final _passwordController = TextEditingController();
  bool showPassword = false;

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
                    "Vai se tratar main yasuo dos infernos",
                    style: TextStyle(
                        fontSize: 16,
                        color: themeNotifier.isDarkMode
                            ? Colors.white54
                            : Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50),
                        GradientTextField(
                            hintText: "E-mail",
                            controller: _usernameController),
                        SizedBox(
                          height: 20,
                        ),
                        GradientTextField(
                          hintText: "Password",
                          controller: _usernameController,
                          obscureText: !showPassword,
                          suffixButton: IconButton(
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
                            Navigator.pushReplacementNamed(context, "/home");
                            // final loginState =
                            //     Provider.of<LoginState>(context, listen: false);
                            // loginState.login(_usernameController.text,
                            //     _passwordController.text);
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
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()),
                                );
                              },
                            ),
                            TextButton(
                              child: Text("Cadastrar-se",
                                  style: TextStyle(color: Colors.purple)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserRegistrationScreen(),
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
      ),
    );
  }
}
