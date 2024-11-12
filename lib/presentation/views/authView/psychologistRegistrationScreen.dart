import 'package:feelhope/components/gradient_textField.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/logoText.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PsychologistRegisterScreen extends StatefulWidget {
  @override
  State<PsychologistRegisterScreen> createState() => _PsychologistRegisterScreenState();
}

class _PsychologistRegisterScreenState extends State<PsychologistRegisterScreen> {
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _nomeClinicaController = TextEditingController();
  final _crmController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
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
                        color: themeNotifier.isDarkMode ? Colors.white54 : Colors.black54,
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
                        "Crie sua conta - Psicólogo",
                        style: TextStyle(
                          fontSize: 16,
                          color: themeNotifier.isDarkMode ? Colors.white54 : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      _buildInputFields(),
                      _buildCheckboxAndButton(),
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

  Widget _buildInputFields() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _nomeController, hintText: "Nome"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _sobrenomeController, hintText: "Sobrenome"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _emailController, hintText: "E-mail"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(
            controller: _senhaController,
            hintText: "Senha",
            obscureText: !_showPassword,
            suffixButton: IconButton(
              icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _cpfController, hintText: "Cpf"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _telefoneController, hintText: "Telefone"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _nomeClinicaController, hintText: "Nome da Clínica"),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradientTextField(controller: _crmController, hintText: "CRM"),
        ),
      ],
    );
  }

  Widget _buildCheckboxAndButton() {
    return Column(
      children: [
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
            Text("Termo de uso", style: TextStyle(color: Colors.blue)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,8,0,8),
          child: GradienteButton(
            text: "Confirmar",
            onPressed: () {},
            width: 130,
            gradient: LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
            textColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
