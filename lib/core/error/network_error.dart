import 'package:clean_architecture_assignment/core/error/base_error.dart';

class NetworkError extends BaseError {
  NetworkError({required super.httpError, super.message = ""});
}
