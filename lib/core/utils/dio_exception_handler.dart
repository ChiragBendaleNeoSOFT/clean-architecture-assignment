import 'package:clean_architecture_assignment/core/error/network_error.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class DioExceptionHandler {
  static Either<NetworkError, T> handle<T>(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.badResponse:
        return Left(
          NetworkError(
            message:
                dioError.response?.data is Map &&
                    dioError.response?.data["message"] != null
                ? dioError.response?.data["message"]
                : "Something went wrong",
            httpError: dioError.response?.statusCode ?? 400,
          ),
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Left(
          NetworkError(
            message: "Connection timeout with API server",
            httpError: 408,
          ),
        );

      case DioExceptionType.cancel:
        return Left(
          NetworkError(
            message: "Request to API server was cancelled",
            httpError: 499,
          ),
        );

      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return Left(
          NetworkError(message: "Something went wrong", httpError: 500),
        );

      case DioExceptionType.connectionError:
        return Left(
          NetworkError(
            message: "Please check internet connection.",
            httpError: 503,
          ),
        );
    }
  }
}
