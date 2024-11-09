import 'package:feelhope/components/gradient_formFIeld.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/data/datasources/remote/user_remote_datasource.dart';
import 'package:feelhope/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Import para formatar a data

class EditProfileScreen extends StatefulWidget {
  final UsuarioModel usuario;

  EditProfileScreen({required this.usuario});

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
    
    _idController = TextEditingController(text: widget.usuario.id.toString());
    _nameController = TextEditingController(text: widget.usuario.nome);
    _lastNameController = TextEditingController(text: widget.usuario.sobrenome);
    _emailController = TextEditingController(text: widget.usuario.email);
    _phoneController = TextEditingController(text: widget.usuario.telefone);
    _cpfController = TextEditingController(text: widget.usuario.cpf);

    // Configura a data de nascimento inicial, se estiver disponível
    if (widget.usuario.dataNascimento != null) {
      _selectedDate = widget.usuario.dataNascimento;
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
                _buildDatePickerField('Data de Nascimento'),
                SizedBox(height: 20),
                Column(
                  children: [
                    GradienteButton(
                      text: "Alterar foto de perfil",
                      onPressed: _changeProfilePicture,
                      gradient: LinearGradient(colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      textColor: Colors.white,
                    ),
                    SizedBox(height: 20),
                    GradienteButton(
                      text: "Salvar perfil",
                      onPressed: _saveProfile,
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
        // Abre o DatePicker e espera a seleção do usuário
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
                ? DateFormat('yyyy-MM-dd').format(_selectedDate!) // Exibe no formato ano-mês-dia
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

  void _changeProfilePicture() {
    // Função para alterar foto de perfil (lógica de seleção de imagem pode ser adicionada aqui)
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final remoteDataSource = Provider.of<UsuarioRemoteDataSource>(context, listen: false);

        // Cria um novo objeto UsuarioModel com os dados atualizados
        final updatedUser = UsuarioModel(
          id: widget.usuario.id, // Certifique-se de que o ID está sendo passado corretamente
          nome: _nameController.text,
          sobrenome: _lastNameController.text,
          email: _emailController.text,
          telefone: _phoneController.text,
          cpf: _cpfController.text,
          dataNascimento: _selectedDate,
        );

        // Envia o PUT para atualizar os dados do perfil
        await remoteDataSource.updateUser(updatedUser);

        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil atualizado com sucesso!')),
        );

        Navigator.pushNamed(context, "/profile"); // Volta para a tela anterior

      } catch (e) {
        // Exibe um erro se a atualização falhar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar perfil')),
        );
        print("Erro ao salvar perfil: $e");
      }
    }
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
