import 'package:clean_architecture_assignment/core/error/base_error.dart';
import 'package:clean_architecture_assignment/core/services/network_connectivity/network_connectivity.dart';
import 'package:clean_architecture_assignment/features/users/data/data_mapping/user_data_mapper.dart';
import 'package:clean_architecture_assignment/features/users/data/datasources/user_data_source.dart';
import 'package:clean_architecture_assignment/features/users/data/models/users_response.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';

import 'package:clean_architecture_assignment/features/users/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource local;
  final UserDatasource remote;
  final NetworkConnectivityService network;

  UserRepositoryImpl({
    required this.local,
    required this.remote,
    required this.network,
  });

  @override
  Future<Either<BaseError, List<UserEntity>>> getUsers(
    int page,
    int limit,
  ) async {
    final Either<BaseError, UsersResponse> response;
    final isConnected = await network.isConnected;
    if (isConnected) {
      response = await remote.fetchUsers(page, limit);
    } else {
      response = await local.fetchUsers(page, limit);
    }
    return response.fold(
      (error) => Left(error),
      (result) => Right(result.users.map((e) => e.toDomain()).toList()),
    );
  }
}
