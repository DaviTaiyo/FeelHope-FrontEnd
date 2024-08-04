import 'package:feelhope/components/gradient_formFIeld.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _incomeController = TextEditingController();
  final _additionalDataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(_nameController, 'Nome de preferência'),
                _buildTextField(
                    _emailController, 'E-mail', TextInputType.emailAddress),
                _buildTextField(
                    _phoneController, 'Telefone', TextInputType.phone),
                _buildTextField(_addressController, 'Endereço'),
                _buildTextField(
                    _incomeController, 'Renda mensal', TextInputType.number),
                _buildTextField(
                    _additionalDataController, 'Dados complementares'),
                SizedBox(height: 20),
                Column(
                  children: [
                    GradienteButton(
                    text: "Alterar foto de perfil",
                    onPressed: _changeProfilePicture,
                    gradient: LinearGradient(
                        colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                    textColor: Colors.white),
                SizedBox(height: 20),
                GradienteButton(
                    text: "Salvar perfil",
                    onPressed: _saveProfile,
                    gradient: LinearGradient(
                        colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                    textColor: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType inputType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GradientFormField(
        label: label,
        controller: controller,
        inputType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o e-mail';
          }
          return null;
        },
      ),
    );
  }

  void _changeProfilePicture() {
    // Função para alterar foto de perfil
    // Adicione a lógica de seleção de imagem aqui
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Salvar perfil
      // Adicione a lógica para salvar as informações do perfil aqui
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _incomeController.dispose();
    _additionalDataController.dispose();
    super.dispose();
  }
}
