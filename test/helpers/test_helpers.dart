import 'package:clean_architecture_assignment/features/users/domain/entities/user_entity.dart';

class TestHelpers {
  static UserEntity getMockUser() {
    return UserEntity(
      id: 1,
      email: 'test@example.com',
      firstName: 'John',
      lastName: 'Doe',
      avatar: 'https://example.com/avatar.jpg',
    );
  }

  static List<UserEntity> getMockUsers() {
    return [
      UserEntity(
        id: 1,
        email: 'john@example.com',
        firstName: 'John',
        lastName: 'Doe',
        avatar: 'https://example.com/avatar1.jpg',
      ),
      UserEntity(
        id: 2,
        email: 'jane@example.com',
        firstName: 'Jane',
        lastName: 'Smith',
        avatar: 'https://example.com/avatar2.jpg',
      ),
    ];
  }

  static Map<String, dynamic> getMockUsersResponse() {
    return {
      'page': 1,
      'total': 12,
      'per_page': 6,
      'total_pages': 2,
      'data': [
        {
          'id': 1,
          'email': 'john@example.com',
          'first_name': 'John',
          'last_name': 'Doe',
          'avatar': 'https://example.com/avatar1.jpg',
        },
        {
          'id': 2,
          'email': 'jane@example.com',
          'first_name': 'Jane',
          'last_name': 'Smith',
          'avatar': 'https://example.com/avatar2.jpg',
        },
      ],
    };
  }
}
