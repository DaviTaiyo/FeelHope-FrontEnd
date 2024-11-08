import 'package:feelhope/data/models/user_model.dart';
import 'package:feelhope/domain/repositories/user_repository.dart';

class LoginUsuario {
  final UsuarioRepository repository;

  LoginUsuario(this.repository);

  Future<UsuarioModel?> call(String email, String senha) async {
    return await repository.login(email, senha);
  }
}

class RegistrarUsuario {
  final UsuarioRepository repository;

  RegistrarUsuario(this.repository);

  Future<String> call(UsuarioModel usuario) async {
    return await repository.register(usuario);
  }
}