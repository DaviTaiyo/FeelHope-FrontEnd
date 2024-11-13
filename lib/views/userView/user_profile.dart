import 'package:feelhope/models/Usuario_model.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/userView/User_EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UsuarioService _usuarioService = UsuarioService();
  Usuario? usuario;

  @override
  void initState() {
    super.initState();
    fetchUsuarioData();
  }

  Future<void> fetchUsuarioData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      final userData = await _usuarioService.getByToken(token);

      setState(() {
        usuario = userData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileItem('Nome', usuario?.nome ?? 'Não disponível'),
            _buildProfileItem(
                'Sobrenome', usuario?.sobrenome ?? 'Não disponível'),
            _buildProfileItem('E-mail', usuario?.email ?? 'Não disponível'),
            _buildProfileItem(
                'Telefone', usuario?.telefone ?? 'Não disponível'),
            _buildProfileItem('Cpf', usuario?.cpf ?? 'Não disponível'),
            _buildProfileItem(
              'Data de nascimento',
              usuario?.dataNascimento != null
                  ? DateFormat('dd/MM/yyyy').format(usuario!.dataNascimento!)
                  : "Não disponível",
            ),
            usuario?.nomeClinica == null ? SizedBox() : _buildProfileItem('Nome da Clinica', usuario?.nomeClinica ?? ""),
            usuario?.crm == null ? SizedBox() : _buildProfileItem('CRM', usuario?.crm.toString() ?? ""),
            Spacer(),
            GradienteButton(
              text: "Editar Perfil",
              onPressed: () {
                if (usuario != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                          usuario: usuario), // Passa o objeto usuario
                    ),
                  );
                }
              },
              gradient: LinearGradient(
                colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          trailing: Text(
            value, style: TextStyle(fontSize: 15),
          ),
        ),
        Divider(),
      ],
    );
  }
}
