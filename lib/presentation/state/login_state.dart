import 'package:feelhope/data/models/user_model.dart';
import 'package:feelhope/domain/usecases/login_user.dart';
import 'package:flutter/material.dart';

class UsuarioLoginViewModel extends ChangeNotifier {
  final LoginUsuario loginUsuario;
  UsuarioModel? usuario;
  bool isLoading = false;
  String? error;

  UsuarioLoginViewModel(this.loginUsuario);

  Future<void> login(String email, String senha) async {
    isLoading = true;
    error = null;  // Limpa qualquer erro anterior
    notifyListeners();

    try {
      usuario = await loginUsuario(email, senha);
      error = null;  // Se o login foi bem-sucedido, limpa o erro
    } catch (e) {
      usuario = null;  // Define `usuario` como `null` para indicar falha no login
      error = "Falha no login. Verifique suas credenciais.";  // Define a mensagem de erro
    } finally {
      isLoading = false;
      notifyListeners();  // Notifica os listeners sobre as atualizações
    }
  }
}
