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
}
