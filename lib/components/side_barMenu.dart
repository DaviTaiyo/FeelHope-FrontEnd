import 'package:feelhope/views/userView/user_homePage.dart';
import 'package:feelhope/views/userView/user_profile.dart';
import 'package:flutter/material.dart';

class SideBarMenu extends StatelessWidget {
  @override
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
                  backgroundImage: AssetImage('assets/default_avatar.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Nome do Usuário',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'email@exemplo.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          buildMenuItem(Icons.home, 'Home', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserHomepage()));
          }),
          buildMenuItem(Icons.person, 'Profile', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
          }),
          buildMenuItem(Icons.description_sharp, 'Documents', () {
          }),
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

Future<bool> showLogoutConfirmation(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Deseja sair?"),
        content: Text("Tem certeza que deseja sair?"),
        actions: <Widget>[
          TextButton(
            child: Text("Não"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text("Sim"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ) ?? false;
}