import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';
import 'package:clean_architecture_assignment/features/users/domain/usecases/get_users_usecase.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_event.dart';
import 'package:clean_architecture_assignment/features/users/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  bool _hasMore = true;

  UserBloc(this.getUsersUseCase) : super(UserDataInitialState()) {
    // Specific event handler for FetchUsers
    on<FetchUsers>((event, emit) {
      fetchInitialUsersList();
    });
    on<SearchUsers>((event, emit) {
      searchUser(event.query);
    });
    on<RefreshFetchUsers>((event, emit) {
      refreshUsers();
    });

    on<LoadMoreUsers>((event, emit) {
      loadMoreUsers();
    });
  }

  Future<void> fetchInitialUsersList() async {
    _hasMore = true;
    emit(UserDataLoadingState());
    await _fetchUserList(page: 1);
  }

  Future<void> refreshUsers() async {
    fetchInitialUsersList();
  }

  void loadMoreUsers() {
    if (state is! UserDataSuccessState || !_hasMore) return;
    final currentState = state as UserDataSuccessState;
    final nextPage = currentState.page + 1;
    emit(UserDataLoadingMoreState(page: nextPage, users: currentState.users));
    _fetchUserList(page: nextPage);
  }

  Future<void> _fetchUserList({required int page, int limit = 20}) async {
    final response = await getUsersUseCase(
      params: UsersParams(page: page, limit: limit),
    );
    response.fold(
      (error) {
        emit(UserDataFailureState(error.message));
      },
      (result) {
        List<UserEntity> allUsers = [];
        if (state is UserDataLoadingMoreState) {
          final currentState = state as UserDataLoadingMoreState;
          allUsers = [...currentState.users, ...result];
        } else {
          allUsers = result;
        }
        if (result.isEmpty) {
          _hasMore = false;
        }
        emit(UserDataSuccessState(users: allUsers, page: page, limit: limit));
      },
    );
  }

  void searchUser(String query) {
    if (state is! UserDataSuccessState) return;

    UserDataSuccessState currentState = state as UserDataSuccessState;
    final allUsers = currentState.users;
    if (query.isEmpty) {
      emit(
        UserDataSuccessState(
          users: allUsers,
          page: currentState.page,
          limit: currentState.limit,
        ),
      );
    } else {
      final regex = RegExp('^$query', caseSensitive: false);

      final filteredUsers = allUsers.where((user) {
        final firstNameMatch = regex.hasMatch(user.firstName);
        final lastNameMatch = regex.hasMatch(user.lastName);
        final emailMatch = regex.hasMatch(user.email);

        return firstNameMatch || lastNameMatch || emailMatch;
      }).toList();
      emit(
        UserDataSearchSuccessState(
          users: currentState.users,
          page: currentState.page,
          limit: currentState.limit,
          results: filteredUsers,
        ),
      );
    }
  }
}
