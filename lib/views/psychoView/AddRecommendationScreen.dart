import 'package:flutter/material.dart';

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

  void _submitRecommendation() {
    if (_titleController.text.isNotEmpty &&
        _subtitleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      // Cria o mapa de dados
      final newRecommendation = {
        "title": _titleController.text,
        "subtitle": _subtitleController.text,
        "description": _descriptionController.text,
      };

      // Adiciona a imagem somente se o campo não estiver vazio
      if (_imageUrlController.text.isNotEmpty) {
        newRecommendation["imageUrl"] = _imageUrlController.text;
      }

      Navigator.pop(context, newRecommendation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Recomendações"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(labelText: "Subtítulo"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Descrição"),
              maxLines: 3,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: "URL da Imagem (Opcional)"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRecommendation,
              child: Text("Adicionar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF9A4DFF),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
