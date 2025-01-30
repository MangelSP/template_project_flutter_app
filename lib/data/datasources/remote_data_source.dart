import 'package:dio/dio.dart';
import 'package:finance_connect_app/domain/entities/user_entity.dart';

abstract class RemoteDataSource {
  Future<UserEntity> getUser();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({required this.dio});

  @override
  Future<UserEntity> getUser() async {
    final response = await dio.get('https://api.example.com/user');
    if (response.statusCode == 200) {
      return UserEntity(
        id: response.data['id'],
        name: response.data['name'],
        email: response.data['email'],
      );
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
