import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Application logger
class Logger {
  static const String _defaultTag = 'OpenFund';
  
  /// Log debug message
  static void debug(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      final logTag = tag ?? _defaultTag;
      developer.log(
        message,
        name: logTag,
        error: error,
        stackTrace: stackTrace,
        level: 0,
      );
    }
  }
  
  /// Log info message
  static void info(String message, {String? tag}) {
    final logTag = tag ?? _defaultTag;
    developer.log(
      message,
      name: logTag,
      level: 800,
    );
  }
  
  /// Log warning message
  static void warning(String message, {String? tag, Object? error}) {
    final logTag = tag ?? _defaultTag;
    developer.log(
      '⚠️ $message',
      name: logTag,
      error: error,
      level: 900,
    );
  }
  
  /// Log error message
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    final logTag = tag ?? _defaultTag;
    developer.log(
      '❌ $message',
      name: logTag,
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
  
  /// Log network request
  static void network({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
    int? statusCode,
    dynamic response,
  }) {
    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln('🌐 Network Request');
      buffer.writeln('   Method: $method');
      buffer.writeln('   URL: $url');
      
      if (headers != null && headers.isNotEmpty) {
        buffer.writeln('   Headers: $headers');
      }
      
      if (body != null) {
        buffer.writeln('   Body: $body');
      }
      
      if (statusCode != null) {
        buffer.writeln('   Status: $statusCode');
      }
      
      if (response != null) {
        buffer.writeln('   Response: $response');
      }
      
      developer.log(
        buffer.toString(),
        name: '$_defaultTag.Network',
        level: 0,
      );
    }
  }
  
  /// Measure execution time
  static Future<T> measureTime<T>(
    String operation,
    Future<T> Function() task, {
    String? tag,
  }) async {
    if (kDebugMode) {
      final stopwatch = Stopwatch()..start();
      try {
        final result = await task();
        stopwatch.stop();
        debug(
          '⏱️ $operation completed in ${stopwatch.elapsedMilliseconds}ms',
          tag: tag,
        );
        return result;
      } catch (e, stackTrace) {
        stopwatch.stop();
        error(
          '⏱️ $operation failed after ${stopwatch.elapsedMilliseconds}ms',
          tag: tag,
          error: e,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    } else {
      return task();
    }
  }
}