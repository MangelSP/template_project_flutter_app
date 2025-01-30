import 'package:finance_connect_app/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDataSource {
  Future<UserEntity?> getUser();
  Future<void> cacheUser(UserEntity user);
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  LocalDataSourceImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  @override
  Future<UserEntity?> getUser() async {
    final id = await secureStorage.read(key: 'user_id');
    final name = sharedPreferences.getString('user_name');
    final email = await secureStorage.read(key: 'user_email');

    if (id != null && name != null && email != null) {
      return UserEntity(id: id, name: name, email: email);
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserEntity user) async {
    await secureStorage.write(key: 'user_id', value: user.id);
    sharedPreferences.setString('user_name', user.name);
    await secureStorage.write(key: 'user_email', value: user.email);
  }
}
