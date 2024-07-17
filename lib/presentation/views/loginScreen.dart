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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Feel Hope",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            Text("Vai se tratar main yasuo dos infernos"),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: !showPassword,
            ),
            IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                final loginState = Provider.of<LoginState>(context, listen: false);
                loginState.login(_usernameController.text,
                    _passwordController.text);
              }),
              Consumer<LoginState>(builder: (context, state, child) {
                if (state.user != null) {
                  return Text("Logged in as: ${state.user!.username}!");
                } else if (state.error != null) {
                  return Text("Error: ${state.error}");
                } else {
                  return Container();
                }
              }),
          ],
        ),
      ),
    );
  }
}
