import 'dart:convert';
import 'package:feelhope/models/Sentimento_model.dart';
import 'package:http/http.dart' as http;

class SentimentoService {
  static const String baseUrl = 'https://10.0.2.2:7002/api/sentimento';

  // Método para obter todos os sentimentos
  Future<List<Sentimento>> getSentimentos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Sentimento.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar sentimentos');
    }
  }

  // Método para obter sentimentos filtrados por usuário, usando o token de autenticação
  Future<List<Sentimento>> getSentimentosByUsuario(String token, int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuario/$usuarioId'), // Endpoint atualizado para incluir usuarioId
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Sentimento.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar sentimentos do usuário');
    }
  }
}
