import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';

/// Base API client for network operations
class ApiClient {
  final String baseUrl;
  final http.Client httpClient;
  final Map<String, String> defaultHeaders;

  ApiClient({
    required this.baseUrl,
    http.Client? httpClient,
    Map<String, String>? defaultHeaders,
  })  : httpClient = httpClient ?? http.Client(),
        defaultHeaders = defaultHeaders ??
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            };

  /// Performs GET request
  Future<T> get<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);
      final response = await httpClient.get(
        uri,
        headers: {...defaultHeaders, ...?headers},
      );

      return _processResponse(response, fromJson);
    } catch (e) {
      throw NetworkException('GET request failed: $e');
    }
  }

  /// Performs POST request
  Future<T> post<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await httpClient.post(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: body != null ? jsonEncode(body) : null,
      );

      return _processResponse(response, fromJson);
    } catch (e) {
      throw NetworkException('POST request failed: $e');
    }
  }

  /// Performs PUT request
  Future<T> put<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await httpClient.put(
        uri,
        headers: {...defaultHeaders, ...?headers},
        body: body != null ? jsonEncode(body) : null,
      );

      return _processResponse(response, fromJson);
    } catch (e) {
      throw NetworkException('PUT request failed: $e');
    }
  }

  /// Performs DELETE request
  Future<T> delete<T>({
    required String endpoint,
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await httpClient.delete(
        uri,
        headers: {...defaultHeaders, ...?headers},
      );

      return _processResponse(response, fromJson);
    } catch (e) {
      throw NetworkException('DELETE request failed: $e');
    }
  }

  /// Process HTTP response
  T _processResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('Unauthorized access');
    } else if (response.statusCode == 404) {
      throw NotFoundException('Resource not found');
    } else {
      throw ServerException(
        'Server error: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }

  void dispose() {
    httpClient.close();
  }
}