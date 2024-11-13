import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/relatorio_service.dart';
import 'package:feelhope/views/userView/UserReportDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PsyUserReportScreen extends StatefulWidget {
  final int usuarioId;

  const PsyUserReportScreen({Key? key, required this.usuarioId}) : super(key: key);

  @override
  State<PsyUserReportScreen> createState() => _PsyUserReportScreenState();
}

class _PsyUserReportScreenState extends State<PsyUserReportScreen> {
  final RelatorioService _relatorioService = RelatorioService();
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;
  String errorMessage = "";
  String? token;

  @override
  void initState() {
    super.initState();
    fetchRelatorios();
  }

  Future<void> fetchRelatorios() async {
    final token = await _getToken();

    if (token == null) {
      setState(() {
        isLoading = false;
        errorMessage = "Token de autenticação não encontrado.";
      });
      return;
    }

    try {
      final fetchedReports = await _relatorioService.getRelatoriosByUsuario(token, widget.usuarioId);
      setState(() {
        reports = fetchedReports;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Erro ao carregar relatórios: $e";
      });
    }
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios"),
        actions: [ThemeSwitch()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
              : reports.isEmpty
                  ? Center(child: Text("Nenhum relatório encontrado."))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        final report = reports[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportDetailScreen(reportId: report["id"]),
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
                                        report["sentimentos"] ?? "Relatório",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Intensidade: ${report["nivel"]}",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        report["descricaoRelatorio"] ?? "",
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
    );
  }
}
