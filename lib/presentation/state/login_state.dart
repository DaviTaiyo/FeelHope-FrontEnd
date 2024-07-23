import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';

class LoginState with ChangeNotifier {
  final LoginUser loginUser;
  User? _user;
  String? _error;

  LoginState(this.loginUser);

  User? get user => _user;
  String? get error => _error;

  Future<void> login(String username, String password) async {
    final result = await loginUser(username, password);
    if (result != null) {
      _user = result;
      _error = null;
    } else {
      _error = 'Login failed';
    }

    notifyListeners();
  }
}
