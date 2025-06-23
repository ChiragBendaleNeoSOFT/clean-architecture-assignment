import 'package:clean_architecture_assignment/features/users/data/models/user_model.dart';
import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';

class UserMapper {
  static UserEntity toDomain(UserModel model) {
    return UserEntity(
      id: model.id,
      avatar: model.avatar,
      email: model.email,
      lastName: model.lastName,
      firstName: model.firstName,
    );
  }
}
