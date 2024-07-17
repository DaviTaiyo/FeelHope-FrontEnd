import 'package:feelhope/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> login(String username, String password);
}
