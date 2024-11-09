import 'package:feelhope/data/datasources/remote/user_remote_datasource.dart';
import 'package:feelhope/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a instância do `UsuarioRemoteDataSource` do Provider
    final usuarioRemoteDataSource = Provider.of<UsuarioRemoteDataSource>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          FutureBuilder<UsuarioModel>(
            future: usuarioRemoteDataSource.getUserInfo(), // Faz o GET do usuário
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 114, 23, 233),
                        Color.fromARGB(255, 150, 193, 250),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              } else if (snapshot.hasError) {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 114, 23, 233),
                        Color.fromARGB(255, 150, 193, 250),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Erro ao carregar dados',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                final usuario = snapshot.data!;
                return DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 114, 23, 233),
                        Color.fromARGB(255, 150, 193, 250),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: usuario.foto != null
                            ? NetworkImage(usuario.foto!)
                            : AssetImage('assets/default_avatar.png') as ImageProvider,
                      ),
                      SizedBox(height: 10),
                      Text(
                        usuario.nome ?? 'Nome não disponível',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        usuario.email ?? 'Email não disponível',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 114, 23, 233),
                        Color.fromARGB(255, 150, 193, 250),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Nenhum dado disponível',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            },
          ),
          buildMenuItem(Icons.home, 'Home', () {
            Navigator.pushNamed(context, '/home');
          }),
          buildMenuItem(Icons.person, 'Profile', () {
            Navigator.pushNamed(context, '/profile');
          }),
          buildMenuItem(Icons.description_sharp, 'Documents', () {
            Navigator.pushNamed(context, '/documents');
          }),
          buildMenuItem(Icons.settings, 'Settings', () {
            Navigator.pushNamed(context, '/settings');
          }),
          buildMenuItem(Icons.help_outline, 'Help', () {
            Navigator.pushNamed(context, '/help');
          }),
          Divider(),
          buildMenuItem(Icons.logout, 'Logout', () {
            // Handle logout action
          }),
        ],
      ),
    );
  }

  Widget buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
