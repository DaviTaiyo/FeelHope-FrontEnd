import 'package:dio/dio.dart';
import 'package:feelhope/data/models/user_model.dart';

class UsuarioRemoteDataSource {
  final Dio dio;

  UsuarioRemoteDataSource(this.dio);

  Future<UsuarioModel> login(String email, String senha) async {
    final response = await dio.post('/Usuario/login', data: {
      'email': email,
      'Senha': senha,
    });
    print(response.data);
    if (response.statusCode == 200) {
      return UsuarioModel.fromJson(response.data);
    } else {
      throw Exception('Falha no login');
    }
  }

  Future<String> register(UsuarioModel usuario) async {
  final response = await dio.post(
    '/usuario/registrar',
    data: usuario.toJson(),
  );

  if (response.statusCode == 200) {
    if (response.data is String) {
      return response.data;
    } else {
      return 'Usuário cadastrado com sucesso!';
    }
  } else {
    throw Exception('Falha no registro');
  }
}

}
