import 'package:dartz/dartz.dart';
import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/domain/entities/auth_entity.dart';
import 'package:finance_connect_app/domain/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, AuthEntity>> call(
      String email, String password) async {
    return await repository.login(email, password);
  }
}
