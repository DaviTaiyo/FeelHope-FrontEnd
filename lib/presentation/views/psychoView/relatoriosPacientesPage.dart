import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';

class RelatoriosPacientesPage extends StatelessWidget {
  final List<String> pacientes = [
    "Guilherme Mendes",
    "Maria Julia",
    "Lucas Poggers"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios dos Pacientes"),
        actions: [ThemeSwitch()],
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                pacientes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RelatoriosPage(paciente: pacientes[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class RelatoriosPage extends StatelessWidget {
  final String paciente;

  RelatoriosPage({required this.paciente});

  final Map<String, List<Map<String, String>>> relatorios = {
    "Guilherme Mendes": [
      {
        "data": "05/06/2024",
        "descricao": "Estou me sentindo triste",
        "sentimento": "Tristeza",
        "escala": "Intensa"
      },
      {
        "data": "01/05/2024",
        "descricao": "Estou feliz",
        "sentimento": "Felicidade",
        "escala": "Média"
      },
    ],
    "Maria Julia": [
      {
        "data": "07/04/2024",
        "descricao": "Estou animada",
        "sentimento": "Alegria",
        "escala": "Baixa"
      },
      {
        "data": "12/03/2024",
        "descricao": "Sinto-me ansiosa",
        "sentimento": "Ansiedade",
        "escala": "Moderada"
      },
    ],
    "Lucas Poggers": [
      {
        "data": "18/06/2024",
        "descricao": "Dia tranquilo",
        "sentimento": "Calma",
        "escala": "Moderada"
      },
      {
        "data": "22/07/2024",
        "descricao": "Sentindo-se estressado",
        "sentimento": "Estresse",
        "escala": "Alto"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paciente),
        actions: [ThemeSwitch()],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Relatórios",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...relatorios[paciente]!.map((relatorio) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  relatorio["descricao"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Data: ${relatorio["data"]!}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Sentimento: ${relatorio["sentimento"]!}",
                      style: TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Intensidade: ${relatorio["escala"]!}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RelatorioDetalhePage(relatorio: relatorio),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class RelatorioDetalhePage extends StatelessWidget {
  final Map<String, String> relatorio;

  RelatorioDetalhePage({required this.relatorio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(relatorio["descricao"]!),
        actions: [ThemeSwitch()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Data:  ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A4DFF),
                  ),
                ),
                Text(
                  relatorio["data"]!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Sentimento:  ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A4DFF),
                  ),
                ),
                Text(
                  relatorio["sentimento"]!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Intensidade:  ",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A4DFF),
                  ),
                ),
                Text(
                  relatorio["escala"]!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Relatório",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      relatorio["descricao"]!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
