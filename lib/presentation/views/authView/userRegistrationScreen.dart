import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Para formatar a data

class UserRegistrationScreen extends StatefulWidget {
  final Function registrarUsuario; // Função de registro

  UserRegistrationScreen({required this.registrarUsuario});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  bool _isTermsAccepted = false;
  bool _showPassword = false;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _confirmRegistration() async {
  if (_selectedDate == null) {
    _showMessage("Por favor, selecione uma data de nascimento.");
    return;
  }
  if (!_isTermsAccepted) {
    _showMessage("Aceite os Termos de Uso para continuar.");
    return;
  }

  final usuario = UsuarioModel(
    nome: _nomeController.text,
    sobrenome: _sobrenomeController.text,
    email: _emailController.text,
    senha: _senhaController.text,
    telefone: _telefoneController.text,
    cpf: _cpfController.text,
    dataNascimento: _selectedDate,
    //token: '',  // Caso precise de um valor padrão para token
  );

  try {
    final resultMessage = await widget.registrarUsuario(usuario);
    _showMessage(resultMessage);
  } catch (e) {
    _showMessage("Erro no registro: $e");
  }
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
            child: Column(
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
                            : Colors.black54,
                      ),
                    ),
                    Spacer(),
                    ThemeSwitch(),
                  ],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logotext(),
                      Text(
                        "Crie sua conta - Usuario",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeNotifier.isDarkMode
                              ? Colors.white54
                              : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 8),
                        child: GradientTextField(
                          controller: _nomeController,
                          hintText: "Nome",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GradientTextField(
                          controller: _sobrenomeController,
                          hintText: "Sobrenome",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GradientTextField(
                          controller: _emailController,
                          hintText: "E-mail",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GradientTextField(
                          controller: _senhaController,
                          hintText: "Senha",
                          obscureText: !_showPassword,
                          suffixButton: IconButton(
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GradientTextField(
                          controller: _cpfController,
                          hintText: "Cpf",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GradientTextField(
                          controller: _telefoneController,
                          hintText: "Telefone",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: GradientTextField(
                              controller: _dataNascimentoController,
                              hintText: "Data de Nascimento",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
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
                          Text("Aceito os "),
                          Text(
                            "Termo de uso",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      GradienteButton(
                        text: "Confirmar",
                        onPressed: _confirmRegistration,
                        width: 130,
                        gradient: LinearGradient(
                          colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/registerpsico");
                        },
                        child: Text("Você é Paciente? Faça sua conta aqui"),
                      ),
                    ],
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
