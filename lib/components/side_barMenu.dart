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
                colors: [Color.fromARGB(255, 114, 23, 233), Color.fromARGB(255, 150, 193, 250),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://i.scdn.co/image/ab6761610000e5eb4d218856ab5e3f805c25682e'),
                ),
                SizedBox(height: 10),
                Text(
                  'Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          buildMenuItem(Icons.home, 'Home', () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          buildMenuItem(Icons.person, 'Profile', () {
            Navigator.pushReplacementNamed(context, '/profile');
          }),
          buildMenuItem(Icons.description_sharp, 'Documents', () {
            Navigator.pushReplacementNamed(context, '/documents');
          }),
          buildMenuItem(Icons.settings, 'Settings', () {
            Navigator.pushReplacementNamed(context, '/settings');
          }),
          buildMenuItem(Icons.help_outline, 'Help', () {
            Navigator.pushReplacementNamed(context, '/help');
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
