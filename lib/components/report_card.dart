import 'package:feelhope/views/psychoView/relatoriosPacientesPage.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String period;

  const ReportCard({required this.period});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text("Últimos relatórios reportados em $period:"),
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
            ),
          ),
        ),
      ),
    );
  }
}
