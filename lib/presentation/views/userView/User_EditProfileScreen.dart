import 'package:feelhope/components/gradient_formFIeld.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic usuario;

  EditProfileScreen({this.usuario});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cpfController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com os valores existentes do usuário
    _idController = TextEditingController(text: widget.usuario.id.toString());
    _nameController = TextEditingController(text: widget.usuario.nome ?? '');
    _lastNameController = TextEditingController(text: widget.usuario.sobrenome ?? '');
    _emailController = TextEditingController(text: widget.usuario.email ?? '');
    _phoneController = TextEditingController(text: widget.usuario.telefone ?? '');
    _cpfController = TextEditingController(text: widget.usuario.cpf ?? '');

    // Se existir, inicialize a data de nascimento
    _selectedDate = widget.usuario.dataNascimento != null
        ? DateTime.parse(widget.usuario.dataNascimento)
        : null;
  }

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
                _buildDisplayField(_idController, 'ID'), // Campo apenas para exibir o ID
                _buildTextField(_nameController, 'Nome'),
                _buildTextField(_lastNameController, 'Sobrenome'),
                _buildTextField(_emailController, 'E-mail', TextInputType.emailAddress),
                _buildTextField(_phoneController, 'Telefone', TextInputType.phone),
                _buildTextField(_cpfController, 'CPF'),
                _buildDatePickerField('Data de Nascimento'),
                SizedBox(height: 20),
                Column(
                  children: [
                    GradienteButton(
                      text: "Alterar foto de perfil",
                      onPressed: () {},
                      gradient: LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    GradienteButton(
                      text: "Salvar perfil",
                      onPressed: _salvarPerfil,
                      gradient: LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvarPerfil() {
    if (_formKey.currentState?.validate() ?? false) {
      // Salva o perfil ou envia para o servidor.
      print("Perfil salvo com sucesso!");
      // Aqui você pode chamar uma função para salvar no backend
    }
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
            return 'Por favor, insira $label';
          }
          return null;
        },
      ),
    );
  }

  // Campo de texto para exibir o ID sem permitir edição
  Widget _buildDisplayField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: true, // Definir como somente leitura
      ),
    );
  }

  Widget _buildDatePickerField(String label) {
    return GestureDetector(
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: AbsorbPointer(
        child: GradientFormField(
          label: label,
          controller: TextEditingController(
            text: _selectedDate != null
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                : '',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, selecione $label';
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }
}
