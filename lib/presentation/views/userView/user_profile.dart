import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/presentation/views/userView/User_EditProfileScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
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
            _buildProfileItem('Nome de preferência', 'UserName'),
            _buildProfileItem('E-mail', 'u***e@outlook.com'),
            _buildProfileItem('Telefone', '*******0010'),
            _buildProfileItem('Alterar foto de perfil', ''),
            _buildProfileItem('Endereço', 'Rua augusta, Nº 900'),
            _buildProfileItem('Renda mensal', '1.820,00'),
            _buildProfileItem('Dados complementares', ''),
            Spacer(),
            GradienteButton(
              text: "Editar Perfil",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
              gradient: LinearGradient(
                  colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title, String value) {

    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text(
            value,
          ),
        ),
        Divider(),
      ],
    );
  }
}
