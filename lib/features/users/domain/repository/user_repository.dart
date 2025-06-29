import 'package:clean_architecture_assignment/core/errors/base_error.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<BaseError, List<UserEntity>>> getUsers(int page, int limit);
}
