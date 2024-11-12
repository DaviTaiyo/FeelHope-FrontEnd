import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';

class PsyEditProfileScreen extends StatefulWidget {
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String cpf;
  final String clinicName;
  final String crm;

  PsyEditProfileScreen({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.cpf,
    required this.clinicName,
    required this.crm,
  });

  @override
  _PsyEditProfileScreenState createState() => _PsyEditProfileScreenState();
}

class _PsyEditProfileScreenState extends State<PsyEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cpfController;
  late TextEditingController _clinicNameController;
  late TextEditingController _crmController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _surnameController = TextEditingController(text: widget.surname);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _cpfController = TextEditingController(text: widget.cpf);
    _clinicNameController = TextEditingController(text: widget.clinicName);
    _crmController = TextEditingController(text: widget.crm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [ThemeSwitch()],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                _buildTextField(_nameController, 'Nome de preferência'),
                _buildTextField(_surnameController, "Sobrenome"),
                _buildTextField(
                    _emailController, 'E-mail', TextInputType.emailAddress),
                _buildTextField(
                    _phoneController, 'Telefone', TextInputType.phone),
                _buildTextField(_cpfController, "CPF"),
                _buildTextField(_clinicNameController, 'Nome da clínica'),
                _buildTextField(_crmController, 'CRM'),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildRoundedButton(
                      text: "Alterar foto de perfil",
                      onPressed: _changeProfilePicture,
                    ),
                    SizedBox(height: 20),
                    _buildRoundedButton(
                      text: "Salvar perfil",
                      onPressed: _saveProfile,
                    ),
                  ],
                ),
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
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira um valor';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRoundedButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 200,
      child: GradienteButton(
        text: text,
        onPressed: onPressed,
        gradient:
            LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
        textColor: Colors.white,
      ),
    );
  }

  void _changeProfilePicture() {
    // Função para alterar foto de perfil
    // Adicione a lógica de seleção de imagem aqui
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'cpf': _cpfController.text,
        'clinicName': _clinicNameController.text,
        'crm': _crmController.text,
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _clinicNameController.dispose();
    _crmController.dispose();
    super.dispose();
  }
}
