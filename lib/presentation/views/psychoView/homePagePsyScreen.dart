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
        backgroundColor: Colors.purple,
        toolbarHeight: 50,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AccountInfoPage()),
                );
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/icon.jpg"),
              ),
            ),
            SizedBox(width: 10),
            Text("Foto"),
            Spacer(),
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Teste de Texto", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ReportCard(period: "24 Horas", reports: "Quatro novos relatórios"),
            ReportCard(period: "7 Dias", reports: "Quatro novos relatórios"),
            ReportCard(period: "30 Dias", reports: "Quatro novos relatórios"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.purple,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: "Home",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: "Pacientes",
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy, color: Colors.black),
            label: "Relatórios",
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final String period;
  final String reports;

  const ReportCard({required this.period, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("Ultimos relatórios reportado em $period:"),
        subtitle: Text(reports),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text("Checar"),
        ),
      ),
    );
  }
}

class AccountInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações da Conta"),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(infoTitle: "Nome", infoDetail: "Gui"),
            ProfileCard(infoTitle: "Email", infoDetail: "gui123@poggers.com"),
            ProfileCard(infoTitle: "Nome da clínica", infoDetail: "PoggersLTDA"),
            ProfileCard(infoTitle: "CRM", infoDetail: "08/4874"),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String infoTitle;
  final String infoDetail;

  const ProfileCard({required this.infoTitle, required this.infoDetail});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(infoTitle, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(infoDetail),
          ],
        ),
      ),
    );
  }
}
