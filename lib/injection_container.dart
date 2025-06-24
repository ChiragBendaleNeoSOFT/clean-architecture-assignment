import 'package:clean_architecture_assignment/core/blocs/locale_bloc/locale_bloc.dart';
import 'package:clean_architecture_assignment/core/services/api_service/api_service.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity_service/network_connectivity_service.dart';
import 'package:clean_architecture_assignment/core/utils/dio_api_interceptor.dart';
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

import 'database/user_db.dart';

final di = GetIt.instance;

void initDi() {
  di.registerLazySingleton(
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

  di.registerLazySingleton(() => DioApiInterceptor());

  di.registerLazySingleton(
    () => Dio()
      ..interceptors.addAll([
        di.get<PrettyDioLogger>(),
        di.get<DioApiInterceptor>(),
      ]),
  );

  di.registerLazySingleton(() => UserDatabase());
  di.registerLazySingleton(() => Connectivity());
  di.registerLazySingleton(() => ApiService(di.get<Dio>()));

  di.registerLazySingleton<NetworkConnectivityService>(
    () => NetworkConnectivityService(),
  );

  di.registerLazySingleton<UserDatasource>(
    () => UserLocalDatasourceImpl(di.get<UserDatabase>()),
    instanceName: "local",
  );

  di.registerLazySingleton<UserDatasource>(
    () =>
        UserRemoteDatasourceImpl(di.get<ApiService>(), di.get<UserDatabase>()),
    instanceName: "remote",
  );

  di.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      local: di.get<UserDatasource>(instanceName: "local"),
      remote: di.get<UserDatasource>(instanceName: "remote"),
      network: di.get<NetworkConnectivityService>(),
    ),
  );

  di.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(di.get<UserRepository>()),
  );

  di.registerFactory<UserBloc>(() => UserBloc(di.get<GetUsersUseCase>()));
  di.registerFactory<LocaleBloc>(() => LocaleBloc());
}
