import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/usuario_service.dart';
import 'package:feelhope/views/psychoView/userReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RelatoriosPacientesPage extends StatefulWidget {
  @override
  _RelatoriosPacientesPageState createState() => _RelatoriosPacientesPageState();
}

class _RelatoriosPacientesPageState extends State<RelatoriosPacientesPage> {
  final UsuarioService _usuarioService = UsuarioService();
  List<Map<String, dynamic>> pacientes = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchPacientes();
  }

  Future<void> fetchPacientes() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      setState(() {
        isLoading = false;
        errorMessage = "Token de autenticação não encontrado.";
      });
      return;
    }

    try {
      // Faz o GET nos usuários e filtra os que não têm CRM
      final usuarios = await _usuarioService.getUsuarios(token);
      setState(() {
        pacientes = usuarios.where((usuario) => usuario['crm'] == null).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Erro ao carregar pacientes: $e";
      });
    }
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
              : ListView.builder(
                  itemCount: pacientes.length,
                  itemBuilder: (context, index) {
                    final paciente = pacientes[index];
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
                          paciente['nome'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          paciente['email'] ?? '',
                          style: TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PsyUserReportScreen(usuarioId: paciente['id']),
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
