import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Response> post(String path, Map<String, dynamic> data) async {
    final response = await _dio.post('https://dummyjson.com/auth$path', data: data); //esta API é API de teste pega no site https://dummyjson.com/docs/auth,
    //deve ser trocada futuramente
    return response;
  }
}
