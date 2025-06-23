abstract class BaseError {
  int httpError;
  String message;

  BaseError({this.httpError = 0, this.message = ""});
}
