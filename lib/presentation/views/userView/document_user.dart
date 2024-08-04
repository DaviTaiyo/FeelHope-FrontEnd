import 'package:flutter/material.dart';

class DocumentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileItem(
              'Termos de uso',
            ),
            _buildProfileItem(
              'Termo de Intermediação',
            ),
            _buildProfileItem(
              'Regras e parâmetros de atuação',
            ),
            _buildProfileItem(
              'Sobre',
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String title,) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.description),
          title: Text(title),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ),
        Divider(),
      ],
    );
  }
}
