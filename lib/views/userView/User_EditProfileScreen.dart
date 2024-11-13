import 'package:feelhope/components/gradient_formFIeld.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/models/Usuario_model.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final Usuario? usuario;

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
  late TextEditingController _dateController;
  late TextEditingController _nomeClinicaController;
  late TextEditingController _crmController;
  UsuarioService _usuarioService = UsuarioService();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    // Inicializa os controladores com os valores do usuário
    _idController = TextEditingController(text: widget.usuario?.id.toString());
    _nameController = TextEditingController(text: widget.usuario?.nome ?? '');
    _lastNameController = TextEditingController(text: widget.usuario?.sobrenome ?? '');
    _emailController = TextEditingController(text: widget.usuario?.email ?? '');
    _phoneController = TextEditingController(text: widget.usuario?.telefone ?? '');
    _cpfController = TextEditingController(text: widget.usuario?.cpf ?? '');
    _nomeClinicaController = TextEditingController(text: widget.usuario?.nomeClinica ?? "");
    _crmController = TextEditingController(text: widget.usuario?.crm ?? "");


    // Inicializa a data de nascimento, se disponível, e configura o controlador de data
    _selectedDate = widget.usuario?.dataNascimento;
    _dateController = TextEditingController(
      text: _selectedDate != null
          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
          : '',
    );
  }

  void _showMessage(String message, {bool popOnClose = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                if (popOnClose) {
                  Navigator.of(context).pop(); // Volta para a tela de perfil
                }
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _alterarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      _showMessage("Token de autenticação ausente. Faça login novamente.");
      return;
    }

    final usuario = Usuario(
      id: widget.usuario?.id,
      nome: _nameController.text,
      sobrenome: _lastNameController.text,
      email: _emailController.text,
      telefone: _phoneController.text,
      cpf: _cpfController.text,
      dataNascimento: _selectedDate,
      nomeClinica: _nomeClinicaController.text,
      crm: _crmController.text
    );

    final resultado = await _usuarioService.alterarUsuario(usuario, token);
    if (resultado != null) {
      _showMessage(resultado, popOnClose: true);
    } else {
      _showMessage("Erro ao registrar o usuário. Tente novamente.");
    }
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
                _buildTextField(_nameController, 'Nome'),
                _buildTextField(_lastNameController, 'Sobrenome'),
                _buildTextField(_emailController, 'E-mail', TextInputType.emailAddress),
                _buildTextField(_phoneController, 'Telefone', TextInputType.phone),
                _buildTextField(_cpfController, 'CPF'),
                widget.usuario?.nomeClinica == null ? SizedBox() : _buildTextField(_nomeClinicaController, 'Nome da Clinica'),
                widget.usuario?.crm == null ? SizedBox() : _buildTextField(_crmController, "CRM"),
                SizedBox(height: 5),
                _buildDatePickerField('Data de Nascimento'),
                SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(height: 10),
                    GradienteButton(
                      text: "Salvar perfil",
                      onPressed: _alterarUsuario,
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
            _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
      child: AbsorbPointer(
        child: GradientFormField(
          label: label,
          controller: _dateController,
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
    _dateController.dispose();
    super.dispose();
  }
}
