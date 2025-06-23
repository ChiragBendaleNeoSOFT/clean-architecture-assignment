import 'package:clean_architecture_assignment/core/error/base_error.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<BaseError, List<UserEntity>>> getUsers(int page, int limit);
}
