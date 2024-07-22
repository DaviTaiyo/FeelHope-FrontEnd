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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              "Feel Hope",
              style: TextStyle(
                  color: Colors.purple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "E-mail", 
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
                border: OutlineInputBorder(borderRadius:
                 BorderRadius.circular(10.0)
                ),
                suffixIcon: IconButton(
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
            Row(
              children: [
                Checkbox(value: false, onChanged: (bool? value) {},
              ),
              Text("Continue logado"),
            ],
          ),
          SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login",
               style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                final loginState = Provider.of<LoginState>(context, listen: false);
                loginState.login(_usernameController.text,
                    _passwordController.text);
                    
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              ),
              ),

              
            SizedBox(height: 20),  
              TextButton(child: 
              Text("Esqueceu sua senha?", style: TextStyle(color: Colors.purple)),
              onPressed: () {},
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


//style: TextStyle(color: Colors.black),
//obscureText: !showPassword,
              //style: TextStyle(color: Colors.black),