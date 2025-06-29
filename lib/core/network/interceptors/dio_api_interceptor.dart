import 'dart:async';

import 'package:dio/dio.dart';

class DioApiInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['x-api-key'] = "reqres-free-v1";
    return handler.next(options);
  }
}
