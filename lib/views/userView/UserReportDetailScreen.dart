import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/relatorio_service.dart';
import 'package:flutter/material.dart';

class ReportDetailScreen extends StatefulWidget {
  final int reportId;

  const ReportDetailScreen({super.key, required this.reportId});

  @override
  _ReportDetailScreenState createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  final RelatorioService _relatorioService = RelatorioService();
  Map<String, dynamic>? reportDetails;
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchReportDetails();
  }

  Future<void> fetchReportDetails() async {
    try {
      final details = await _relatorioService.getRelatorioById(widget.reportId);
      setState(() {
        isLoading = false;
      });

      // Show message if details are null or empty
      if (details == null || details.isEmpty) {
        _showMessage("O usuário não possui relatórios.");
      } else {
        setState(() {
          reportDetails = details;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        errorMessage = "Erro ao carregar detalhes do relatório.";
      });
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Relatório"),
        actions: [ThemeSwitch()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : reportDetails != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow("Sentimento",
                              reportDetails!["sentimentos"] ?? "N/A"),
                          _buildDetailRow("Intensidade",
                              reportDetails!["nivel"]?.toString() ?? "N/A"),
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
                                  reportDetails!["descricaoRelatorio"] ??
                                      "Sem descrição disponível.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text("Detalhes do relatório não encontrados.")),
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
}
