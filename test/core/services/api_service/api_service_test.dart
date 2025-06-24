import 'package:clean_architecture_assignment/core/services/api_service/api_service.dart';
import 'package:clean_architecture_assignment/features/users/data/models/users_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
  });

  group('ApiService', () {
    test('fetchUsers returns UsersResponse on success', () async {
      // ARRANGE
      final mockResponseJson = {
        // Renamed for clarity
        'page': 1,
        'total': 12,
        'per_page': 6,
        'total_pages': 2,
        'data': [
          {
            'id': 1,
            'email': 'test@test.com',
            'first_name': 'Test',
            'last_name': 'User',
            'avatar': 'https://test.com/avatar.jpg',
          },
        ],
      };
      final expectedUsersResponse = UsersResponse.fromJson(mockResponseJson);

      when(
        mockApiService.fetchUsers(6, 1), // Use named parameters for clarity
      ).thenAnswer((_) async => expectedUsersResponse);

      // ACT
      final result = await mockApiService.fetchUsers(
        6,
        1,
      ); // Use named parameters

      // ASSERT
      expect(result, isA<UsersResponse>());
      expect(result.page, equals(expectedUsersResponse.page));
      expect(result.perPage, equals(expectedUsersResponse.perPage));
      expect(result.users.length, equals(expectedUsersResponse.users.length));
      expect(
        result.users.first.id,
        equals(expectedUsersResponse.users.first.id),
      );
      expect(
        result.users.first.email,
        equals(expectedUsersResponse.users.first.email),
      );
      // You can also directly compare the objects if UsersResponse and User have equality implemented (equatable package)
      // expect(result, equals(expectedUsersResponse));
    });

    test('fetchUsers throws DioException on error', () async {
      // Make it async
      // ARRANGE
      final requestOptions = RequestOptions(
        path: '/users',
      ); // Dummy RequestOptions
      final dioException = DioException(
        requestOptions: requestOptions,
        error: 'Network Error', // You can put the original error here
        type: DioExceptionType.unknown, // Or any relevant type
      );

      when(
        mockApiService.fetchUsers(6, 1), // Use named parameters
      ).thenThrow(dioException); // Throw the DioException instance

      // ACT & ASSERT
      // Option 1: Using expectLater for async throws
      expectLater(
        mockApiService.fetchUsers(6, 1), // Use named parameters
        throwsA(isA<DioException>()),
      );

      // Option 2: Using a try-catch if you want to inspect the exception
      // try {
      //   await mockApiService.fetchUsers(limit: 6, page: 1);
      //   fail("Should have thrown DioException");
      // } catch (e) {
      //   expect(e, isA<DioException>());
      //   if (e is DioException) {
      //     expect(e.message, contains('Network Error')); // Or check other properties
      //   }
      // }
    });
  });
}
