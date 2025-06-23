// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UsersResponse {

 int get page; int get total;@JsonKey(name: 'per_page') int get perPage;@JsonKey(name: 'total_pages') int get totalPages;@JsonKey(name: 'data') List<UserModel> get users;
/// Create a copy of UsersResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsersResponseCopyWith<UsersResponse> get copyWith => _$UsersResponseCopyWithImpl<UsersResponse>(this as UsersResponse, _$identity);

  /// Serializes this UsersResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsersResponse&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other.users, users));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,total,perPage,totalPages,const DeepCollectionEquality().hash(users));

@override
String toString() {
  return 'UsersResponse(page: $page, total: $total, perPage: $perPage, totalPages: $totalPages, users: $users)';
}


}

/// @nodoc
abstract mixin class $UsersResponseCopyWith<$Res>  {
  factory $UsersResponseCopyWith(UsersResponse value, $Res Function(UsersResponse) _then) = _$UsersResponseCopyWithImpl;
@useResult
$Res call({
 int page, int total,@JsonKey(name: 'per_page') int perPage,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'data') List<UserModel> users
});




}
/// @nodoc
class _$UsersResponseCopyWithImpl<$Res>
    implements $UsersResponseCopyWith<$Res> {
  _$UsersResponseCopyWithImpl(this._self, this._then);

  final UsersResponse _self;
  final $Res Function(UsersResponse) _then;

/// Create a copy of UsersResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? total = null,Object? perPage = null,Object? totalPages = null,Object? users = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,users: null == users ? _self.users : users // ignore: cast_nullable_to_non_nullable
as List<UserModel>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _UsersResponse implements UsersResponse {
  const _UsersResponse({required this.page, required this.total, @JsonKey(name: 'per_page') required this.perPage, @JsonKey(name: 'total_pages') required this.totalPages, @JsonKey(name: 'data') required final  List<UserModel> users}): _users = users;
  factory _UsersResponse.fromJson(Map<String, dynamic> json) => _$UsersResponseFromJson(json);

@override final  int page;
@override final  int total;
@override@JsonKey(name: 'per_page') final  int perPage;
@override@JsonKey(name: 'total_pages') final  int totalPages;
 final  List<UserModel> _users;
@override@JsonKey(name: 'data') List<UserModel> get users {
  if (_users is EqualUnmodifiableListView) return _users;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_users);
}


/// Create a copy of UsersResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UsersResponseCopyWith<_UsersResponse> get copyWith => __$UsersResponseCopyWithImpl<_UsersResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UsersResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UsersResponse&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&const DeepCollectionEquality().equals(other._users, _users));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,total,perPage,totalPages,const DeepCollectionEquality().hash(_users));

@override
String toString() {
  return 'UsersResponse(page: $page, total: $total, perPage: $perPage, totalPages: $totalPages, users: $users)';
}


}

/// @nodoc
abstract mixin class _$UsersResponseCopyWith<$Res> implements $UsersResponseCopyWith<$Res> {
  factory _$UsersResponseCopyWith(_UsersResponse value, $Res Function(_UsersResponse) _then) = __$UsersResponseCopyWithImpl;
@override @useResult
$Res call({
 int page, int total,@JsonKey(name: 'per_page') int perPage,@JsonKey(name: 'total_pages') int totalPages,@JsonKey(name: 'data') List<UserModel> users
});




}
/// @nodoc
class __$UsersResponseCopyWithImpl<$Res>
    implements _$UsersResponseCopyWith<$Res> {
  __$UsersResponseCopyWithImpl(this._self, this._then);

  final _UsersResponse _self;
  final $Res Function(_UsersResponse) _then;

/// Create a copy of UsersResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? total = null,Object? perPage = null,Object? totalPages = null,Object? users = null,}) {
  return _then(_UsersResponse(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,users: null == users ? _self._users : users // ignore: cast_nullable_to_non_nullable
as List<UserModel>,
  ));
}


}

// dart format on
