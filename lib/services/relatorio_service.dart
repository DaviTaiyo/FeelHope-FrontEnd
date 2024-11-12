import 'dart:convert';
import 'package:http/http.dart' as http;

class RelatorioService {
  static const String baseUrl = 'https://10.0.2.2:7002/api/relatorio';

  Future<List<Map<String, dynamic>>> getRelatoriosByUsuario(String token, int usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuario/$usuarioId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((json) => {
        "id": json["id"] ?? "",
        "sentimentos": json["sentimentos"] ?? "N/A",
        "nivel": json["nivel"]?.toString() ?? "N/A",  // Convertendo `nivel` para string se necessário
        "descricaoRelatorio": json["descricaoRelatorio"] ?? "Sem descrição",
        "audio": json["audio"] ?? "",
        "date": json["date"] ?? "",
      }).toList();
    } else {
      throw Exception('Falha ao carregar relatórios do usuário');
    }
  }

  Future<Map<String, dynamic>> getRelatorioById(int reportId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$reportId'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar detalhes do relatório');
    }
  }

  Future<String?> criarRelatorio(Map<String, dynamic> reportData, String token) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(reportData),
    );

    if (response.statusCode == 201) {
      return "Relatorio criado com Sucesso";
    } else {
      return "Falha ao criar Relatorio ${response.statusCode}";
    }
  }
}
