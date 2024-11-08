import 'package:dio/io.dart';
import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/data/datasources/remote/user_remote_datasource.dart';
import 'package:feelhope/data/repositories/user_repository_impl.dart';
import 'package:feelhope/domain/usecases/login_user.dart';
import 'package:feelhope/presentation/state/login_state.dart';
import 'package:feelhope/presentation/views/authView/forgotPasswordScreen.dart';
import 'package:feelhope/presentation/views/authView/psychologistRegistrationScreen.dart';
import 'package:feelhope/presentation/views/authView/userRegistrationScreen.dart';
import 'package:feelhope/presentation/views/psychoView/homePagePsyScreen.dart';
import 'package:feelhope/presentation/views/psychoView/psyProfileScreen.dart';
import 'package:feelhope/presentation/views/splashscreen.dart';
import 'package:feelhope/presentation/views/userView/document_user.dart';
import 'package:feelhope/presentation/views/userView/user_homePage.dart';
import 'package:feelhope/presentation/views/userView/user_noteScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

void main() {
  final dio = Dio()..options.baseUrl = "https://10.0.2.2:7002/api/";
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };
  final remoteDataSource = UsuarioRemoteDataSource(dio);
  final repository = UsuarioRepositoryImpl(remoteDataSource);
  final loginUsuario = LoginUsuario(repository);
  final registrarUsuario = RegistrarUsuario(repository);
  final registrarPsicologo = RegistrarUsuario(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsuarioLoginViewModel(loginUsuario),
        ),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(registrarUsuario: registrarUsuario, registrarPsicologo: registrarPsicologo),
    ),
  );
}

class MyApp extends StatelessWidget {
  final RegistrarUsuario registrarUsuario;
  final RegistrarUsuario registrarPsicologo;

  MyApp({required this.registrarUsuario, required this.registrarPsicologo});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, ThemeNotifier, child) {
      return MaterialApp(
        title: 'FeelHope App',
        theme: ThemeNotifier.currentTheme,
        home: Splashscreen(),
        routes: {
          "/home": (context) => UserHomepage(),
          "/homePsico": (context) => HomePagePsyco(),
          "/profile": (context) => ProfileScreen(),
          //"/edit-profile": (context) => EditProfileScreen(),
          "/documents": (context) => DocumentScreen(),
          "/user-notes": (context) => UserNoteScreen(),
          "/registerUser": (context) => UserRegistrationScreen(registrarUsuario: registrarUsuario),
          "/registerpsico": (context) => PsychologistRegisterScreen(registrarPsicologo: registrarPsicologo),
          "/forgot-password": (context) => ForgotPasswordScreen(),
        },
      );
    });
  }
}
