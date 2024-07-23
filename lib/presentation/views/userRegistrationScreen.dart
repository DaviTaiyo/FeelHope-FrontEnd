import 'package:feelhope/presentation/views/psychologistRegistrationScreen.dart';
import 'package:flutter/material.dart';


class UserRegistrationScreen extends StatefulWidget {
  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State <UserRegistrationScreen>  {
  
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
                    color: Colors.black
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
                  ),
                  obscureText: true,
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
                    Text("Aceito termo de uso")
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
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
                    decoration: TextDecoration.underline,
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