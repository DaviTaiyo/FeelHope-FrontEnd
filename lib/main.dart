import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/remote/user_remote_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'external/api/api_service.dart';
import 'presentation/state/login_state.dart';
import 'presentation/views/loginScreen.dart';

void main() {
  final apiService = ApiService();
  final userRemoteDataSource = UserRemoteDataSource(apiService);
  final userRepository = UserRepositoryImpl(userRemoteDataSource);
  final loginUser = LoginUser(userRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState(loginUser)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Loginscreen(),
    );
  }
}
