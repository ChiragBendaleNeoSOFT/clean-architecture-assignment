import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_bloc.dart';
import 'package:clean_architecture_assignment/core/network/interceptors/dio_api_interceptor.dart';
import 'package:clean_architecture_assignment/core/services/api_service/api_service.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity_service.dart';
import 'package:clean_architecture_assignment/database/user_database.dart';
import 'package:clean_architecture_assignment/features/users/data/datasources/user_data_source.dart';
import 'package:clean_architecture_assignment/features/users/data/repository/user_repository_impl.dart';
import 'package:clean_architecture_assignment/features/users/domain/repository/user_repository.dart';
import 'package:clean_architecture_assignment/features/users/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'core/services/network_connectivity/network_connectivity_service_test.dart';
import 'core/services/network_connectivity/network_connectivity_service_test.mocks.dart';

final diTest = GetIt.instance;

void initDiTest() {
  diTest.registerLazySingleton(
    () => PrettyDioLogger(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      logPrint: (log) {
        return debugPrint(log as String);
      },
    ),
  );

  diTest.registerLazySingleton(() => DioApiInterceptor());

  diTest.registerLazySingleton(
    () => Dio()
      ..interceptors.addAll([
        diTest.get<PrettyDioLogger>(),
        diTest.get<DioApiInterceptor>(),
      ]),
  );

  diTest.registerLazySingleton(() => UserDatabase());
  diTest.registerLazySingleton(() => MockConnectivity());
  diTest.registerLazySingleton(() => ApiService(diTest.get<Dio>()));

  diTest.registerLazySingleton<NetworkConnectivityService>(
    () => NetworkConnectivityService(),
  );

  diTest.registerLazySingleton<UserDatasource>(
    () => UserLocalDatasourceImpl(diTest.get<UserDatabase>()),
    instanceName: "local",
  );

  diTest.registerLazySingleton<UserDatasource>(
    () => UserRemoteDatasourceImpl(
      diTest.get<ApiService>(),
      diTest.get<UserDatabase>(),
    ),
    instanceName: "remote",
  );

  diTest.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      local: diTest.get<UserDatasource>(instanceName: "local"),
      remote: diTest.get<UserDatasource>(instanceName: "remote"),
      network: diTest.get<NetworkConnectivityService>(),
    ),
  );

  diTest.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(diTest.get<UserRepository>()),
  );

  diTest.registerFactory<UserBloc>(
    () => UserBloc(diTest.get<GetUsersUseCase>()),
  );
  diTest.registerFactory<LocaleBloc>(() => LocaleBloc());
}
