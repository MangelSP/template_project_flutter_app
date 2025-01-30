import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  AuthLocalDataSource({required this.secureStorage});

  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'auth_token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'auth_token');
  }
}
