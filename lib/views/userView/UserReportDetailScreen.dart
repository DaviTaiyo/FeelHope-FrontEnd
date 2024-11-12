import 'package:feelhope/components/switchTheme.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class ReportDetailScreen extends StatelessWidget {
  final Map<String, dynamic> report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(report["sentimentos"]?.toString() ?? "Detalhes do Relatório"),
        actions: [ThemeSwitch()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Data", report["date"]?.toString() ?? ""),
            _buildDetailRow("Intensidade", report["nivel"]?.toString() ?? "N/A"),
            _buildDetailRow("Sentimento", report["sentimentos"]?.toString() ?? "N/A"),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Descrição do Relatório",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    report["descricaoRelatorio"]?.toString() ?? "Sem descrição disponível.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            if (report["audio"] != null && report["audio"].isNotEmpty)
              _buildAudioSection(report["audio"].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9A4DFF),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioSection(String base64Audio) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Áudio do Relatório:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF9A4DFF),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text("Reproduzir Áudio"),
          onPressed: () {
            _playAudio(base64Audio);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF9A4DFF),
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  void _playAudio(String base64Audio) {
    Uint8List audioBytes = base64Decode(base64Audio);
    print("Reproduzindo áudio (implementação necessária para reprodução real)");
  }
}
