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

  Future<Usuario?> getByToken(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return Usuario.fromJson(jsonDecode(response.body));
    } else{
      return null;
    }
  }

  Future<String?> registrar(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

    return response.statusCode == 200 ? 'Usuário registrado com sucesso' : null;
  }

  Future<String?> alterarUsuario(Usuario usuario, String token) async {
  if (usuario.id == null) {
    return 'Erro: ID do usuário não pode ser nulo.';
  }

  // Converte o usuário para JSON, garantindo que os campos 'crm' e 'nomeClinica' sejam tratados
  final usuarioJson = usuario.toJson(includeId: false);

  final response = await http.put(
    Uri.parse('$baseUrl/Atualizar/${usuario.id}'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: jsonEncode(usuarioJson),
  );

  print("Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

  if (response.statusCode == 200) {
    return 'Usuário alterado com sucesso';
  } else {
    return 'Erro ao atualizar usuário. Código: ${response.statusCode}';
  }
}


  Future<List<Map<String, dynamic>>> getUsuarios(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/listar'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> usuarios = jsonDecode(response.body);

      return usuarios
          .where((usuario) => usuario['crm'] == null)
          .map((usuario) => {
                'id': usuario['id'],
                'nome': usuario['nome'],
                'email': usuario['email'],
              })
          .toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }
}
