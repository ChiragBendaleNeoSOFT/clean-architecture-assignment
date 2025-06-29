import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioBaseClient {
  final Dio dio;

  DioBaseClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: 'https://reqres.in/api/',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true,
      ),
    );
  }
}
