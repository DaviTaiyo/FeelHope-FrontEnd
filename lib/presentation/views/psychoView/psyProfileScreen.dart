import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/presentation/views/psychoView/psyEditProfileScreen.dart';
import 'package:flutter/material.dart';

class PsyProfileScreen extends StatefulWidget {
  @override
  _PsyProfileScreenState createState() => _PsyProfileScreenState();
}

class _PsyProfileScreenState extends State<PsyProfileScreen> {
  String _name = 'Nome Exemplo';
  String _surname = "Sobrenome";
  String _email = 'email@exemplo.com';
  String _phone = '123456789';
  String _cpf = "54689712";
  String _clinicName = 'Clínica Exemplo';
  String _crm = 'CRM12345';

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
            _buildProfileItem('Nome', _name),
            _buildProfileItem("Sobrenome", _surname),
            _buildProfileItem('E-mail', _email),
            _buildProfileItem('Telefone', _phone),
            _buildProfileItem("CPF", _cpf),
            _buildProfileItem('Nome da Clínica', _clinicName),
            _buildProfileItem('CRM', _crm),
            Spacer(),
            GradienteButton(
              text: "Editar Perfil",
              onPressed: () async {
                final updatedProfile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PsyEditProfileScreen(
                      name: _name,
                      surname: _surname,
                      email: _email,
                      phone: _phone,
                      cpf: _cpf,
                      clinicName: _clinicName,
                      crm: _crm,
                    ),
                  ),
                );

                if (updatedProfile != null) {
                  setState(() {
                    _name = updatedProfile['name'];
                    _surname = updatedProfile['surname'];
                    _email = updatedProfile['email'];
                    _phone = updatedProfile['phone'];
                    _cpf = updatedProfile['cpf'];
                    _clinicName = updatedProfile['clinicName'];
                    _crm = updatedProfile['crm'];
                  });
                }
              },
              gradient: LinearGradient(
                  colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
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
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),
          ),
        ),
        Divider(),
      ],

    );
  }
}
