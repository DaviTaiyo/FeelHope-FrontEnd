import 'package:feelhope/presentation/views/authView/loginScreen.dart';
import 'package:feelhope/presentation/views/psychoView/calendarPage.dart';
import 'package:feelhope/presentation/views/psychoView/pacientesPage.dart';
import 'package:feelhope/presentation/views/psychoView/psyProfileScreen.dart';
import 'package:feelhope/presentation/views/psychoView/relatoriosPacientesPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Menu Principal',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.dark_mode, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      drawer: SideBarMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF9A4DFF),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Recomendações\nIndicado por 8/10 psicólogos",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ReportCard(
              period: "24 Horas",
              reports: "Quatro novos relatórios",
            ),
            SizedBox(height: 40), 
            Center(
              child: Text(
                "Agenda das Sessões dos Pacientes",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarPage()),
                  );
                },
                child: Text("Ver Calendário"),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "A saúde mental é fundamental para o bem-estar geral,\ne o papel do psicólogo é essencial na promoção e manutenção desse bem-estar.",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Nome do Usuário"),
            accountEmail: Text("user@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/icon.jpg"),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9A4DFF),
                  Color(0xFF7F7FFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.file_copy),
            title: Text("Relatórios"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RelatoriosPacientesPage())
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text("Pacientes"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PacientesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("Help"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              bool shouldLogout = await showLogoutConfirmation(context);
              if (shouldLogout) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Loginscreen()),
                );
              }
            },
          ),
        ],
      ),
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

class ReportCard extends StatelessWidget {
  final String period;
  final String reports;

  const ReportCard({required this.period, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Últimos relatórios reportados em $period:"),
        subtitle: Text(reports),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RelatoriosPacientesPage()), 
            );
          },
          child: Text("Checar"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )
          )
        ),
      ),
    );
  }
}
