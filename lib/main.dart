import 'package:feelhope/components/themeNotifier.dart';
import 'package:feelhope/presentation/views/userView/User_EditProfileScreen.dart';
import 'package:feelhope/presentation/views/userView/document_user.dart';
import 'package:feelhope/presentation/views/userView/user_homePage.dart';
import 'package:feelhope/presentation/views/userView/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/remote/user_remote_datasource.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'external/api/api_service.dart';
import 'presentation/state/login_state.dart';
import 'presentation/views/authView/loginScreen.dart';

void main() {
  final apiService = ApiService();
  final userRemoteDataSource = UserRemoteDataSource(apiService);
  final userRepository = UserRepositoryImpl(userRemoteDataSource);
  final loginUser = LoginUser(userRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginState(loginUser)),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'Feel Hope',
          theme: themeNotifier.currentTheme,
          home: Loginscreen(),
          routes: {
            "/home": (context) => UserHomepage(),
            "/profile": (context) => ProfileScreen(),
            "/edit-profile": (context) => EditProfileScreen(),
            "/documents": (context) => DocumentScreen(),
          },
        );
      },
    );
  }
}
