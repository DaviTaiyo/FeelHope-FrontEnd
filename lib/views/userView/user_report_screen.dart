import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/relatorio_service.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/userView/UserReportDetailScreen.dart';
import 'package:feelhope/views/userView/user_noteScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserReportScreen extends StatefulWidget {
  const UserReportScreen({super.key});

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  final RelatorioService _relatorioService = RelatorioService();
  final UsuarioService _usuarioService =
      UsuarioService(); // Instância do serviço de usuário
  List<Map<String, dynamic>> reports = [];
  bool isLoading = true;
  String errorMessage = "";
  String? token;
  int? usuarioId;

  @override
  void initState() {
    super.initState();
    fetchUsuarioData();
  }

  Future<void> fetchUsuarioData() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('authToken');

    if (token != null) {
      try {
        final usuario = await _usuarioService.getByToken(token!);
        setState(() {
          usuarioId = usuario?.id;
        });
        if (usuarioId != null) {
          fetchRelatorios();
        } else {
          setState(() {
            isLoading = false;
            errorMessage = "ID do usuário não encontrado.";
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = "Erro ao carregar dados do usuário: $e";
        });
      }
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Token de autenticação não encontrado.";
      });
    }
  }

  Future<void> fetchRelatorios() async {
    if (token != null && usuarioId != null) {
      try {
        final fetchedReports =
            await _relatorioService.getRelatoriosByUsuario(token!, usuarioId!);
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
    } else {
      setState(() {
        isLoading = false;
        errorMessage = "Token ou ID do usuário está faltando.";
      });
    }
  }

  Future<void> _navigateToAddReport() async {
    final newReport = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => UserNoteScreen(),
      ),
    );

    if (newReport != null) {
      setState(() {
        reports.add(newReport);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatórios"),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(errorMessage, style: TextStyle(color: Colors.red)))
              : reports.isEmpty
                  ? Center(child: Text("Nenhum relatório encontrado."))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportDetailScreen(
                                    reportId: report["id"],
                                  ),
                                ),
                              );
                            },

                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF9A4DFF),
                                    Color(0xFF7F7FFF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Icon(Icons.description,
                                      color: Colors.white, size: 30),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          report["descricaoRelatorio"] ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    report["date"] ?? "",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
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
