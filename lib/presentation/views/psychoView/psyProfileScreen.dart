import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/presentation/views/psychoView/psyEditProfileScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'Nome Exemplo';
  String _email = 'email@exemplo.com';
  String _phone = '123456789';
  String _clinicName = 'Clínica Exemplo';
  String _crm = 'CRM12345';
  String _additionalData = 'Dados complementares';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: Color(0xFF9A4DFF),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileItem('Nome de preferência', _name),
            _buildProfileItem('E-mail', _email),
            _buildProfileItem('Telefone', _phone),
            _buildProfileItem('Nome da Clínica', _clinicName),
            _buildProfileItem('CRM', _crm),
            _buildProfileItem('Dados complementares', _additionalData),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: GradienteButton(
                text: "Editar Perfil",
                onPressed: () async {
                  final updatedProfile = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        name: _name,
                        email: _email,
                        phone: _phone,
                        clinicName: _clinicName,
                        crm: _crm,
                        additionalData: _additionalData,
                      ),
                    ),
                  );

                  if (updatedProfile != null) {
                    setState(() {
                      _name = updatedProfile['name'];
                      _email = updatedProfile['email'];
                      _phone = updatedProfile['phone'];
                      _clinicName = updatedProfile['clinicName'];
                      _crm = updatedProfile['crm'];
                      _additionalData = updatedProfile['additionalData'];
                    });
                  }
                },
                gradient: LinearGradient(
                    colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
