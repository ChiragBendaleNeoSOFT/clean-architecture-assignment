import 'package:clean_architecture_assignment/core/error/base_error.dart';
import 'package:clean_architecture_assignment/core/error/db_error.dart';
import 'package:clean_architecture_assignment/core/error/network_error.dart';
import 'package:clean_architecture_assignment/core/services/api_service/api_service.dart';
import 'package:clean_architecture_assignment/core/utils/dio_exception_handler.dart';
import 'package:clean_architecture_assignment/db/user_db.dart';
import 'package:clean_architecture_assignment/features/users/data/models/users_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserDatasource {
  Future<Either<BaseError, UsersResponse>> fetchUsers(int page, int limit);
}

class UserLocalDatasourceImpl extends UserDatasource {
  UserDatabase userDb;
  UserLocalDatasourceImpl(this.userDb);
  @override
  Future<Either<DbError, UsersResponse>> fetchUsers(int page, int limit) async {
    try {
      final originalResponse = await userDb.getUsers(page: page, limit: limit);
      return Right(originalResponse);
    } catch (e) {
      return Left(DbError(message: "Something went wrong during"));
    }
  }
}

class UserRemoteDatasourceImpl extends UserDatasource {
  ApiService apiService;
  UserDatabase userDb;
  UserRemoteDatasourceImpl(this.apiService, this.userDb);
  @override
  Future<Either<NetworkError, UsersResponse>> fetchUsers(
    int page,
    int limit,
  ) async {
    try {
      final originalResponse = await apiService.fetchUsers(limit, page);
      userDb.insertUsers(originalResponse.users, page);
      return Right(originalResponse);
    } on DioException catch (dioError) {
      return DioExceptionHandler.handle<UsersResponse>(dioError);
    }
  }
}
