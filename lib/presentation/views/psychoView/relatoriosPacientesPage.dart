import 'package:flutter/material.dart';

class RelatoriosPacientesPage extends StatelessWidget {
  final List<String> pacientes = ["Guilherme Mendes", "Maria Julia", "Lucas Poggers"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios dos Pacientes"),
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                pacientes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RelatoriosPage(paciente: pacientes[index])),
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
      {"data": "05/06/2024 12:00", "descricao": "Estou me sentindo triste", "sentimento": "Tristeza", "escala": "8/10"},
      {"data": "01/05/2024 16:00", "descricao": "Estou feliz", "sentimento": "Felicidade", "escala": "10/10"},
    ],
    "Maria Julia": [
      {"data": "07/04/2024 09:00", "descricao": "Estou animada", "sentimento": "Alegria", "escala": "9/10"},
      {"data": "12/03/2024 14:00", "descricao": "Sinto-me ansiosa", "sentimento": "Ansiedade", "escala": "7/10"},
    ],
    "Lucas Poggers": [
      {"data": "18/06/2024 10:00", "descricao": "Dia tranquilo", "sentimento": "Calma", "escala": "9/10"},
      {"data": "22/07/2024 11:00", "descricao": "Sentindo-se estressado", "sentimento": "Estresse", "escala": "6/10"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paciente),
        backgroundColor: Color(0xFF9A4DFF),
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
                color: Colors.black87,
              ),
            ),
          ),
          ...relatorios[paciente]!.map((relatorio) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                title: Text(
                  relatorio["descricao"]!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      "Data e Hora: ${relatorio["data"]!}",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      "Sentimento: ${relatorio["sentimento"]!}",
                      style: TextStyle(color: Colors.black54),
                    ),
                    Text(
                      "Nível de Sentimento: ${relatorio["escala"]!}",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RelatorioDetalhePage(relatorio: relatorio),
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
        backgroundColor: Color(0xFF9A4DFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Data e Hora:",
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
            SizedBox(height: 16),
            Text(
              "Descrição:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9A4DFF),
              ),
            ),
            Text(
              relatorio["descricao"]!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              "Sentimento:",
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
            SizedBox(height: 16),
            Text(
              "Nível de Sentimento:",
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
      ),
    );
  }
}
