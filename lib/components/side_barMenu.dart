import 'package:feelhope/views/userView/user_homePage.dart';
import 'package:feelhope/views/userView/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarMenu extends StatelessWidget {
  final String? nomeUsuario;
  final String? emailUsuario;
  final String? avatarUrl;

  SideBarMenu({this.nomeUsuario, this.emailUsuario, this.avatarUrl});

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
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
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : AssetImage('assets/default_avatar.png')
                          as ImageProvider,
                ),
                SizedBox(height: 10),
                Text(
                  '${nomeUsuario ?? "Usuario indisponivel"}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${emailUsuario ?? "Email indisponivel"}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          buildMenuItem(Icons.home, 'Home', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserHomepage()));
          }),
          buildMenuItem(Icons.person, 'Profile', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          }),
          //buildMenuItem(Icons.description_sharp, 'Documents', () {}),
          Divider(),
          buildMenuItem(Icons.logout, 'Logout', () {
            showLogoutConfirmation(context);
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

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  // Apaga o token do SharedPreferences
  await prefs.remove('authToken');

  // Navega para a tela de login e remove todas as outras telas da pilha de navegação
  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
}

void showLogoutConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Confirmar Logout"),
        content: Text("Tem certeza de que deseja sair?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
              logout(context); // Chama a função de logout
            },
            child: Text("Logout"),
          ),
        ],
      );
    },
  );
}
