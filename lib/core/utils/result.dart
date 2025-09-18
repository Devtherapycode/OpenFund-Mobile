import 'package:equatable/equatable.dart';
import '../errors/failures.dart';

/// Result type for handling success and failure cases
sealed class Result<T> extends Equatable {
  const Result();
  
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure;
  
  T? get data => switch (this) {
    Success<T> success => success.value,
    _ => null,
  };
  
  Failure? get failure => switch (this) {
    Error<T> error => error.failure,
    _ => null,
  };
  
  /// Transform success value
  Result<R> map<R>(R Function(T) mapper) {
    return switch (this) {
      Success<T> success => Success(mapper(success.value)),
      Error<T> error => Error(error.failure),
    };
  }
  
  /// Handle both success and failure cases
  R fold<R>({
    required R Function(T) onSuccess,
    required R Function(Failure) onFailure,
  }) {
    return switch (this) {
      Success<T> success => onSuccess(success.value),
      Error<T> error => onFailure(error.failure),
    };
  }
  
  /// Get value or default
  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T> success => success.value,
      _ => defaultValue,
    };
  }
  
  /// Get value or throw
  T getOrThrow() {
    return switch (this) {
      Success<T> success => success.value,
      Error<T> error => throw Exception(error.failure.message),
    };
  }
}

/// Success result
class Success<T> extends Result<T> {
  final T value;
  
  const Success(this.value);
  
  @override
  List<Object?> get props => [value];
}

/// Error result
class Error<T> extends Result<T> {
  @override
  final Failure failure;
  
  const Error(this.failure);
  
  @override
  List<Object?> get props => [failure];
}