import 'package:feelhope/data/models/user_model.dart';

abstract class UsuarioRepository {
  Future<UsuarioModel?> login(String email, String senha);
  Future<String> register(UsuarioModel usuario);
}
