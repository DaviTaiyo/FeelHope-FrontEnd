import 'package:feelhope/presentation/views/userView/User_EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/data/datasources/remote/user_remote_datasource.dart';
import 'package:feelhope/data/models/user_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioRemoteDataSource =
        Provider.of<UsuarioRemoteDataSource>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: FutureBuilder<UsuarioModel>(
        future: usuarioRemoteDataSource.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar dados"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Nenhum dado disponível"));
          } else {
            final usuario = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildProfileItem('Nome', usuario.nome ?? 'Não disponível'),
                  _buildProfileItem(
                      'Sobrenome', usuario.sobrenome ?? 'Não disponível'),
                  _buildProfileItem(
                      'E-mail', usuario.email ?? 'Não disponível'),
                  _buildProfileItem(
                      'Telefone', usuario.telefone ?? 'Não disponível'),
                  _buildProfileItem('Foto de Perfil', usuario.foto ?? ''),
                  _buildProfileItem('Cpf', usuario.cpf ?? 'Não disponível'),
                  Spacer(),
                  GradienteButton(
                    text: "Editar Perfil",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                              usuario:
                                  usuario), // Passa o objeto `usuario` completo aqui
                        ),
                      );
                    },
                    gradient: LinearGradient(
                      colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            );
          }
        },
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
