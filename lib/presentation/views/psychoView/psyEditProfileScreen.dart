import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String clinicName;
  final String crm;
  final String additionalData;

  EditProfileScreen({
    required this.name,
    required this.email,
    required this.phone,
    required this.clinicName,
    required this.crm,
    required this.additionalData,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _clinicNameController;
  late TextEditingController _crmController;
  late TextEditingController _additionalDataController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _clinicNameController = TextEditingController(text: widget.clinicName);
    _crmController = TextEditingController(text: widget.crm);
    _additionalDataController = TextEditingController(text: widget.additionalData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        backgroundColor: Color(0xFF8A2BE2),
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
                _buildTextField(_clinicNameController, 'Nome da clínica'),
                _buildTextField(_crmController, 'CRM'),
                _buildTextField(
                    _additionalDataController, 'Dados complementares'),
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
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFF0E6FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 14.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF7F7FFF),
            fontSize: 16.0,
          ),
        ),
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
        'email': _emailController.text,
        'phone': _phoneController.text,
        'clinicName': _clinicNameController.text,
        'crm': _crmController.text,
        'additionalData': _additionalDataController.text,
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _clinicNameController.dispose();
    _crmController.dispose();
    _additionalDataController.dispose();
    super.dispose();
  }
}
