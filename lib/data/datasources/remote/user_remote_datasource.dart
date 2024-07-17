import '../../../external/api/api_service.dart';
import '../../models/user_model.dart';


class UserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSource(this.apiService);

  Future<UserModel?> login(String username, String password) async {
    final response = await apiService.post('/login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
