import 'package:dio/dio.dart';
import 'package:feelhope/data/security/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio = Dio();
  final _secureStorage = SecureStorage();

  Future<Response> post(String path, Map<String, dynamic> data) async {
    final response = await _dio.post('https://10.0.2.2:7002/api/$path', data: data);
    return response;
  }

   Future<Response> get(String path) async {
    final token = await _secureStorage.getToken();
    _dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await _dio.get('https://10.0.2.2:7002/api/$path');
    return response;
  }
}
