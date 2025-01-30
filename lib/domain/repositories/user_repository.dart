import 'package:dartz/dartz.dart';
import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUserData();
}
