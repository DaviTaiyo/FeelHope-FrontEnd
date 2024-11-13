import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/services/relatorio_service.dart';
import 'package:feelhope/services/usuario_service.dart'; // Serviço para buscar usuário
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNoteScreen extends StatefulWidget {
  @override
  _UserNoteScreenState createState() => _UserNoteScreenState();
}

class _UserNoteScreenState extends State<UserNoteScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _intensityController = TextEditingController();
  final RelatorioService _relatorioService = RelatorioService();
  final UsuarioService _usuarioService = UsuarioService(); // Instância do serviço de usuário

  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getUsuarioId(); // Obtém o usuário atual ao inicializar
  }

  Future<void> getUsuarioId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      try {
        final usuario = await _usuarioService.getByToken(token);
        if (usuario != null) {
          await prefs.setInt('usuarioId', usuario.id!); // Salva o `usuarioId` no SharedPreferences
        } else {
          setState(() {
            errorMessage = "Falha ao obter o ID do usuário.";
          });
        }
      } catch (e) {
        setState(() {
          errorMessage = "Erro ao obter dados do usuário: $e";
        });
      }
    } else {
      setState(() {
        errorMessage = "Token de autenticação não encontrado.";
      });
    }
  }

  Future<void> _submitReport() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final usuarioId = prefs.getInt('usuarioId'); // Obtém o `usuarioId` do SharedPreferences

    // Verifica se o token e o ID do usuário foram obtidos corretamente
    if (token == null || usuarioId == null) {
      setState(() {
        errorMessage = "Token de autenticação ou ID do usuário não encontrado.";
      });
      return;
    }

    final String description = _descriptionController.text;
    final String feeling = _feelingController.text;
    final int? intensity = int.tryParse(_intensityController.text);

    // Valida os campos de entrada
    if (description.isEmpty || feeling.isEmpty || intensity == null) {
      setState(() {
        errorMessage = "Por favor, preencha todos os campos e use um valor numérico para intensidade.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Dados para o corpo do POST, incluindo o `usuarioId`
    final reportData = {
      'sentimentos': feeling,
      'nivel': intensity,
      'descricaoRelatorio': description,
      'usuarioId': usuarioId, // Passa o `usuarioId` aqui
    };

    final result = await _relatorioService.criarRelatorio(reportData, token);

    setState(() {
      isLoading = false;
    });

    // Lida com o resultado do POST
    if (result == "Relatorio criado com Sucesso") {
      Navigator.pop(context, {
        'title': feeling,
        'description': description,
        'intensity': intensity.toString(),
      });
    } else {
      setState(() {
        errorMessage = result ?? "Erro desconhecido ao criar relatório.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Relatório"),
        actions: [
          ThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Vamos escrever um Relatório para seu terapeuta",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Descreva o que aconteceu...',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "O que sentiu? Se fosse avaliar de 0 a 10",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _feelingController,
                        decoration: InputDecoration(
                          hintText: 'Sentimento',
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _intensityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Intensidade',
                          border: OutlineInputBorder(),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (errorMessage.isNotEmpty)
                  Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (isLoading)
                  Center(child: CircularProgressIndicator())
                else
                  GradienteButton(
                    text: "Enviar",
                    onPressed: _submitReport,
                    gradient: LinearGradient(
                      colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)],
                    ),
                    textColor: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
