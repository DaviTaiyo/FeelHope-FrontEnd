import 'package:feelhope/presentation/views/psychologistRegistrationScreen.dart';
import 'package:flutter/material.dart';


class UserRegistrationScreen extends StatefulWidget {
  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State <UserRegistrationScreen>  {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Voltar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Feel Hope',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Crie sua conta - Usuario",

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),
                ),
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
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    )
                  ),
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
                    labelText: "Telefone",
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
                    Text("Aceito termo de uso")
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isTermsAccepted ? _confirmRegistration : null,
                  child: Text("Confirmar"),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {Navigator.push(
                    context, MaterialPageRoute(
                      builder: (context) => PsychologistRegisterScreen()
                    ),
                  );
                },
                child: Text(
                  "Você é Psicólogo? faça sua conta aqui",
                  style: TextStyle(
                    color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}