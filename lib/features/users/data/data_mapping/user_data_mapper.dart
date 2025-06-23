import 'package:clean_architecture_assignment/features/users/data/models/user_model.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';

extension UserDataMapper on UserModel {
  UserEntity toDomain() {
    return UserEntity(
      id: id,
      avatar: avatar,
      email: email,
      lastName: lastName,
      firstName: firstName,
    );
  }
}
