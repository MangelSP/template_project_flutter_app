import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Response> getUserData() async {
    return await dio.get('https://api.example.com/user');
  }
}
