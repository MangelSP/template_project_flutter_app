import 'package:finance_connect_app/core/utils/device_info.dart';
import 'package:finance_connect_app/data/datasources/auth_local_data_source.dart';
import 'package:finance_connect_app/data/datasources/local_data_source.dart';
import 'package:finance_connect_app/data/datasources/remote_data_source.dart';
import 'package:finance_connect_app/data/repositories/auth_repository_impl.dart';
import 'package:finance_connect_app/data/repositories/user_repository_impl.dart';
import 'package:finance_connect_app/domain/repositories/auth_repository.dart';
import 'package:finance_connect_app/domain/repositories/user_repository.dart';
import 'package:finance_connect_app/domain/usecases/auth/login_user.dart';
import 'package:finance_connect_app/domain/usecases/get_user_data.dart';
import 'package:finance_connect_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:finance_connect_app/presentation/bloc/device/device_bloc.dart';
import 'package:finance_connect_app/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => UserBloc(getUserData: sl()));
  sl.registerFactory(() => AuthBloc(loginUser: sl()));
  sl.registerFactory(() => DeviceBloc(deviceInfo: sl()));

  //Services
  sl.registerLazySingleton(() => DeviceInfo());

  // Use cases
  sl.registerLazySingleton(() => GetUserData(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(secureStorage: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FlutterSecureStorage());
}
