// ignore_for_file: invalid_annotation_target

import 'package:clean_architecture_assignment/features/users/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_response.freezed.dart';
part 'users_response.g.dart';

@freezed
abstract class UsersResponse with _$UsersResponse {
  const factory UsersResponse({
    required int page,
    required int total,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'data') required List<UserModel> users,
  }) = _UsersResponse;

  factory UsersResponse.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseFromJson(json);
}
