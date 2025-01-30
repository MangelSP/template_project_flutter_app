import 'package:dartz/dartz.dart';
import 'package:finance_connect_app/core/errors/exceptions.dart';
import 'package:finance_connect_app/core/errors/failures.dart';
import 'package:finance_connect_app/data/datasources/local_data_source.dart';
import 'package:finance_connect_app/data/datasources/remote_data_source.dart';
import 'package:finance_connect_app/domain/entities/user_entity.dart';
import 'package:finance_connect_app/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      // Intenta obtener los datos del almacenamiento local
      final localUser = await localDataSource.getUser();
      if (localUser != null) {
        return Right(localUser);
      }

      // Si no hay datos locales, obtén los datos de la API
      final remoteUser = await remoteDataSource.getUser();
      await localDataSource.cacheUser(remoteUser); // Guarda los datos en local
      return Right(remoteUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Error desconocido: $e'));
    }
  }
}
