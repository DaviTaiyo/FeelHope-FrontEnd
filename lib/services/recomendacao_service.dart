import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationService {
  static const String baseUrl = 'https://10.0.2.2:7002/api/recomendacao';

  // Método para obter recomendações pelo ID do usuário
  Future<List<Map<String, dynamic>>> getRecommendationsByUserId(String token, int userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuario/$userId'), // Define o endpoint para o usuário específico
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Cabeçalho de autorização
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => {
        "titulo": json["titulo"] ?? "Sem título",
        "subtitulo": json["subtitulo"] ?? "Sem subtítulo",
        "descricao": json["descricao"] ?? "Sem descrição",
        "imageUrl": json["imageUrl"] ?? "",
      }).toList();
    } else {
      throw Exception('Falha ao carregar recomendações');
    }
  }

  Future<List<Map<String, dynamic>>> getRecommendations(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Cabeçalho de autorização
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);

      return list.map((json) => {
        "titulo": json["titulo"] ?? "Sem titulo",
        "subtitulo": json["subtitulo"] ?? "Sem subtítulo",
        "descricao": json["descricao"] ?? "Sem descrição",
        "imageUrl": json["imageUrl"] ?? "",
      }).toList();
    } else {
      throw Exception("Falha ao carregar Recomendações");
    }
  }

  Future<String?> createRecommendation(Map<String, dynamic> recommendationData, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl), // Endpoint base para criação de recomendação
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Cabeçalho de autorização
      },
      body: jsonEncode(recommendationData),
    );

    // Verifica se a resposta é bem-sucedida
    if (response.statusCode == 201) {
      return "Recomendação criada com sucesso";
    } else {
      // Retorna a mensagem de erro com o código de status
      return "Falha ao criar recomendação: ${response.statusCode}";
    }
  }
}
