import 'package:equatable/equatable.dart';

/// Base failure class
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.code});
}

/// Server failure
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {super.code, this.statusCode});

  @override
  List<Object?> get props => [...super.props, statusCode];
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.code});
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, {super.code});
}

/// Validation failure
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure(super.message, {super.code, this.errors});

  @override
  List<Object?> get props => [...super.props, errors];
}