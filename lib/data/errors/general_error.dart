class TimeoutException implements Exception {}

class HttpException implements Exception {
  final dynamic error;
  HttpException([this.error]);
}

/// 404 Exception
class NotFoundException extends HttpException {
  NotFoundException([error]) : super(error);
}

/// 500 Exception
class ServerErrorException extends HttpException {
  ServerErrorException([error]) : super(error);
}

/// 401 Exception
class UnauthorizedException extends HttpException {
  UnauthorizedException([error]) : super(error);
}

class ConnectionErrorException extends HttpException {
  ConnectionErrorException([error]) : super(error);
}

class AuthErrorException extends HttpException {
  AuthErrorException([error]) : super(error);
}

class ValidationErrorException extends HttpException {
  final dynamic validate;

  ValidationErrorException(this.validate, [error]) : super(error);
}

class FailedException extends HttpException {
  final String message;

  FailedException(this.message, [error]) : super(error);
}
