import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/domain/entities/user_entity.dart';
import 'package:finance_connect_app/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserData {
  final UserRepository repository;

  GetUserData(this.repository);

  Future<Either<Failure, UserEntity>> call() async {
    return await repository.getUserData();
  }
}
