import 'package:dartz/dartz.dart';
import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/domain/entities/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(String email, String password);
}
