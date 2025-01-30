import 'package:dartz/dartz.dart';
import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/data/datasources/auth_local_data_source.dart';
import 'package:finance_connect_app/domain/entities/auth_entity.dart';
import 'package:finance_connect_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, AuthEntity>> login(
      String email, String password) async {
    // Simulamos una autenticación exitosa
    if (email == 'test@example.com' && password == 'password') {
      final token = 'fake_jwt_token';
      await localDataSource.saveToken(token);
      return Right(AuthEntity(token));
    } else {
      return Left(ServerFailure('Invalid credentials'));
    }
  }
}
