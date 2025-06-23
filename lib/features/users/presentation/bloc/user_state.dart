import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class UserState {}

/// Initial/default state
class UserDataInitialState extends UserState {
  UserDataInitialState();
}

/// Loading state for initial load
class UserDataLoadingState extends UserState {
  UserDataLoadingState();
}

/// Loading more state during pagination
class UserDataLoadingMoreState extends UserState {
  final int page;
  final List<UserEntity> users;
  UserDataLoadingMoreState({required this.page, required this.users});
}

/// Success state with fetched user list
class UserDataSuccessState extends UserState {
  final List<UserEntity> users;
  final int page;
  final int limit;

  UserDataSuccessState({
    required this.users,
    required this.page,
    required this.limit,
  });
}

/// Failure state with error message
class UserDataFailureState extends UserState {
  final String message;

  UserDataFailureState(this.message);
}

/// Search result state
class UserDataSearchSuccessState extends UserDataSuccessState {
  final List<UserEntity> results;

  UserDataSearchSuccessState({
    required super.users,
    required super.page,
    required super.limit,
    required this.results,
  });
}
