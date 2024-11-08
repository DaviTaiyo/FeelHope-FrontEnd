import 'package:feelhope/domain/repositories/user_repository.dart';
import 'package:feelhope/data/datasources/remote/user_remote_datasource.dart';
import 'package:feelhope/data/models/user_model.dart';

class UsuarioRepositoryImpl implements UsuarioRepository {
  final UsuarioRemoteDataSource remoteDataSource;

  UsuarioRepositoryImpl(this.remoteDataSource);

  @override
  Future<UsuarioModel?> login(String email, String senha) async {
    try {
      final usuarioModel = await remoteDataSource.login(email, senha);
      return usuarioModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register(UsuarioModel usuario) async { // Altere para Future<String>
    try {
      final resultMessage = await remoteDataSource.register(usuario); // Recebe a mensagem de sucesso
      return resultMessage;
    } catch (e) {
      rethrow;
    }
  }
}
