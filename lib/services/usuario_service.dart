import 'dart:convert';
import 'package:feelhope/models/Usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioService {
  static const String baseUrl = 'https://10.0.2.2:7002/api/usuario';

  Future<Usuario?> login(String email, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<String?> registrar(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

    print("Status Code: ${response.statusCode}");
    print("Resposta: ${response.body}");

    return response.statusCode == 200 ? 'Usuário registrado com sucesso' : null;
  }
}
