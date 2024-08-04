import 'package:flutter/material.dart';

class RelatoriosPacientesPage extends StatelessWidget {
  final List<String> pacientes = ["Guilherme Mendes", "Maria Julia", "Lucas Poggers"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios dos Pacientes"),
      ),
      body: ListView.builder(
        itemCount: pacientes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pacientes[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RelatoriosPage(paciente: pacientes[index])),
              );
            },
          );
        },
      ),
    );
  }
}

class RelatoriosPage extends StatelessWidget {
  final String paciente;

  RelatoriosPage({required this.paciente});

  final List<Map<String, String>> novosRelatorios = [
    {"data": "05/06/2024 12:00", "descricao": "Estou me sentindo triste", "sentimento": "Tristeza", "escala": "8/10"},
    {"data": "01/05/2024 16:00", "descricao": "Estou feliz", "sentimento": "Felicidade", "escala": "10/10"},
    {"data": "07/04/2024 9:00", "descricao": "Estou com depressão", "sentimento": "Medo", "escala": "10/10"},
  ];

  final List<Map<String, String>> relatoriosPassados = [
    {"data": "25/12/2023 08:00", "descricao": "Hoje tive um dia feliz", "sentimento": "felicidade", "escala": "10/10"},
    {"data": "08/10/2023 14:00", "descricao": "Hoje foi um dia pessimo", "sentimento": "angustia ", "escala": "8,5/10"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios de $paciente"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Novos Relatórios", style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: novosRelatorios.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(novosRelatorios[index]["descricao"]!),
                  subtitle: Text(novosRelatorios[index]["data"]!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RelatorioDetalhePage(relatorio: novosRelatorios[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Relatórios Passados", style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: relatoriosPassados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(relatoriosPassados[index]["descricao"]!),
                  subtitle: Text(relatoriosPassados[index]["data"]!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RelatorioDetalhePage(
                          relatorio: relatoriosPassados[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
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
        title: Text("Detalhe do Relatório"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Data e Hora: ${relatorio["data"]!}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Descrição: ${relatorio["descricao"]!}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Sentimento: ${relatorio["sentimento"]!}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("Nível de Sentimento: ${relatorio["escala"]}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}