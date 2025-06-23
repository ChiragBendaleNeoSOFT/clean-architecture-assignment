abstract class UserEvent {}

class FetchUsers extends UserEvent {}

class RefreshFetchUsers extends UserEvent {}

class LoadMoreUsers extends UserEvent {}

class SearchUsers extends UserEvent {
  final String query;
  SearchUsers(this.query);
}
