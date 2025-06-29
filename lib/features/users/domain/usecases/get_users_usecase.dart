import 'package:clean_architecture_assignment/core/errors/base_error.dart';
import 'package:clean_architecture_assignment/core/utils/usecase.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:clean_architecture_assignment/features/users/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUsersUseCase
    extends Usecase<Future<Either<BaseError, List<UserEntity>>>, UsersParams> {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  @override
  Future<Either<BaseError, List<UserEntity>>> call({
    required UsersParams params,
  }) async {
    return await _repository.getUsers(params.page, params.limit);
  }
}

class UsersParams {
  int page;
  int limit;
  UsersParams({required this.page, required this.limit});
}
