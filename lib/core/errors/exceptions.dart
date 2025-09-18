/// Base exception class
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Network related exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

/// Server related exceptions
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(super.message, {super.code, this.statusCode});
}

/// Cache related exceptions
class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}

/// Authentication exceptions
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.code});
}

/// Resource not found exception
class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code});
}

/// Validation exception
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException(super.message, {super.code, this.errors});
}