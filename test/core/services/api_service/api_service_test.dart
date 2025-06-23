import 'package:clean_architecture_assignment/core/services/api_service/api_service.dart';
import 'package:clean_architecture_assignment/features/users/data/models/users_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// class MockDio extends Mock implements Dio {}

class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService apiService;
  late Dio mockDio;

  setUp(() async {
    await dotenv.load(fileName: '.env');
    final baseUrl = dotenv.env['BASE_URL'] ?? 'https://reqres.in/api';
    mockDio = Dio()
      ..options = BaseOptions(
        baseUrl: 'https://reqres.in/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      );
    apiService = MockApiService();
  });

  group('ApiService', () {
    test('fetchUsers returns UsersResponse on success', () async {
      final mockResponse = {
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

      when(
        mockDio.get(
          "https://reqres.in/api/users",
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/users'),
        ),
      );

      final result = await apiService.fetchUsers(6, 1);

      expect(result, isA<UsersResponse>());
      expect(result.page, equals(1));
      expect(result.perPage, equals(6));
      expect(result.users.length, equals(1));
      expect(result.users.first.id, equals(1));
      expect(result.users.first.email, equals('test@test.com'));
    });

    test('fetchUsers throws DioException on error', () {
      when(
        mockDio.get(
          "https://reqres.in/api/users",
          queryParameters: anyNamed('queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/users'),
          error: 'Failed to fetch users',
        ),
      );

      expect(() => apiService.fetchUsers(6, 1), throwsA(isA<DioException>()));
    });
  });
}
