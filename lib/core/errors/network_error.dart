import 'package:clean_architecture_assignment/core/errors/base_error.dart';

class NetworkError extends BaseError {
  NetworkError({required super.httpError, super.message = ""});
}
