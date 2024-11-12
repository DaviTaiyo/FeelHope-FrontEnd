import 'package:feelhope/views/userView/User_EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';

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
              _buildProfileItem('Nome', 'Não disponível'),
              _buildProfileItem('Sobrenome', 'Não disponível'),
              _buildProfileItem('E-mail', 'Não disponível'),
              _buildProfileItem('Telefone', 'Não disponível'),
              _buildProfileItem('Foto de Perfil', ''),
              _buildProfileItem('Cpf', 'Não disponível'),
              Spacer(),
              GradienteButton(
                text: "Editar Perfil",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                },
                gradient: LinearGradient(
                  colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
                ),
                textColor: Colors.white,
              ),
            ],
          ),
        ));
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
