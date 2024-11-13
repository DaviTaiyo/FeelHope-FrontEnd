import 'package:feelhope/components/gradiente_button.dart';
import 'package:feelhope/components/switchTheme.dart';
import 'package:feelhope/services/recomendacao_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecommendationScreen extends StatefulWidget {
  @override
  _AddRecommendationScreenState createState() =>
      _AddRecommendationScreenState();
}

class _AddRecommendationScreenState extends State<AddRecommendationScreen> {
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final RecommendationService _recommendationService = RecommendationService();

  bool isLoading = false;
  String errorMessage = '';

  Future<void> _submitRecommendation() async {
    // Pega o token e o ID do usuário do armazenamento compartilhado
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final usuarioId = prefs.getInt('usuarioId');

    if (token == null || usuarioId == null) {
      setState(() {
        errorMessage = "Token de autenticação ou ID do usuário não encontrado.";
      });
      return;
    }

    if (_titleController.text.isEmpty ||
        _subtitleController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      setState(() {
        errorMessage = "Todos os campos devem ser preenchidos.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Prepara os dados da recomendação para o envio
    final recommendationData = {
      'titulo': _titleController.text,
      'subtitulo': _subtitleController.text,
      'descricao': _descriptionController.text,
      'usuarioId': usuarioId,
      'imageUrl':
          _imageUrlController.text.isNotEmpty ? _imageUrlController.text : null,
    };

    try {
      final result = await _recommendationService.createRecommendation(
          recommendationData, token);
      if (result == 'Recomendação criada com sucesso') {
        Navigator.pop(context, true); // Indica sucesso na criação
      } else {
        setState(() {
          errorMessage = result ?? "Erro ao criar recomendação.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Erro ao enviar recomendação: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recomendações"),
        actions: [ThemeSwitch()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "Nova Recomendação",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9A4DFF),
                  ),
                ),
                SizedBox(height: 20),
                _buildInputField(
                  controller: _titleController,
                  label: "Título",
                  hintText: "Exemplo: Pratique a Gratidão",
                ),
                _buildInputField(
                  controller: _subtitleController,
                  label: "Subtítulo",
                  hintText: "Exemplo: Encontre um momento positivo no dia",
                ),
                _buildInputField(
                  controller: _descriptionController,
                  label: "Descrição",
                  hintText: "Escreva uma descrição completa...",
                  maxLines: 4,
                ),
                _buildInputField(
                  controller: _imageUrlController,
                  label: "URL da Imagem (Opcional)",
                  hintText: "Cole o link da imagem aqui",
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
                  Center(
                    child: GradienteButton(
                      text: "Adicionar Recomendação",
                      onPressed: () {
                        _submitRecommendation();
                      },
                      width: 50,
                      gradient: LinearGradient(
                          colors: [Color(0xFF7F7FFF), Color(0xFF9A4DFF)]),
                      textColor: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
