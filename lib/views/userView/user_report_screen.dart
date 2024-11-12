import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/views/userView/UserReportDetailScreen.dart';
import 'package:feelhope/views/userView/user_noteScreen.dart';
import 'package:flutter/material.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({super.key});

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  List<Map<String, String>> mockReports = [
    {
      "title": "Relatório de Bem-estar",
      "date": "2023-10-01",
      "description": "Hoje me senti muito motivado.",
      "intensity": "Moderado",
      "Sentimento": "Felicidade"
    },
  ];

  Future<void> _navigateToAddReport() async {
  final newReport = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (context) => UserNoteScreen(),
    ),
  );

  if (newReport != null) { // Adiciona apenas se newReport não for nulo
    setState(() {
      mockReports.add(newReport);
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios do Usuário"),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mockReports.length,
          itemBuilder: (context, index) {
            final report = mockReports[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportDetailScreen(report: report),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF9A4DFF), Color(0xFF7F7FFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.description, color: Colors.white, size: 30),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            report["title"] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Intensidade: ${report["intensity"]}",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Sentimento: ${report["Sentimento"]}",
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 4,),
                          Text(
                            report["description"] ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      report["date"] ?? "",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddReport,
        child: Icon(Icons.add),
      ),
    );
  }
}
