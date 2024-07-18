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
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Nome", 
              labelStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
            
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
              obscureText: !showPassword,
              style: TextStyle(color: Colors.black),
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
              child: Text("Login", style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                final loginState = Provider.of<LoginState>(context, listen: false);
                loginState.login(_usernameController.text,
                    _passwordController.text);
                    
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple
              ),
              ),
              
            
              Consumer<LoginState>(builder: (context, state, child) {
                if (state.user != null) {
                  return Text(
                    "Logged in as: ${state.user!.username}!",
                    style: TextStyle(color: Colors.white),
                  );
                } else if (state.error != null) {
                  return Text("Error: ${state.error}", 
                  style: TextStyle(color: Colors.white),
                );
                } else {
                  return Container();
                }
              }),
            ])
            
          
        ),
      );
  }
}
