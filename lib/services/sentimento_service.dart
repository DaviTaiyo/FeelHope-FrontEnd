import 'dart:convert';
import 'package:feelhope/models/Sentimento_model.dart';
import 'package:http/http.dart' as http;

class SentimentoService {
  static const String baseUrl = 'https://seu-backend.com/api/sentimento';

  Future<List<Sentimento>> getSentimentos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => Sentimento.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar sentimentos');
    }
  }
}
