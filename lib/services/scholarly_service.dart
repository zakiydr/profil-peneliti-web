import 'package:dio/dio.dart';
import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/models/scholars/scholars.dart';

import '../models/pub_detail/pub_detail.dart';

class ScholarlyService {
  // API Constants
  static const String _baseUrl = 'https://scholar-profile.vercel.app/';
  static const String _searchEndpoint = 'goscholar/author/compact/search/';
  static const String _authorByNameEndpoint = 'goscholar/author/name/';
  static const String _authorDetailEndpoint = 'goscholar/author/';
  static const String _pubDetailEndpoint = 'goscholar/pub/search/';

  // Default timeout durations
  static const Duration _connectTimeout = Duration(seconds: 20);
  static const Duration _receiveTimeout = Duration(seconds: 30);

  // Instance of Dio for HTTP requests
  late final Dio _dio;

  /// Constructor that initializes Dio with base configuration
  ScholarlyService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type, X-Auth-Token'
        },
        receiveTimeout: _receiveTimeout,
        connectTimeout: _connectTimeout,
      ),
    );
  }

  Future<Scholars> getScholars(String author) async {
    try {
      final Response response = await _dio.get(
        _searchEndpoint,
        queryParameters: {'author': author},
      );

      if (response.statusCode == 200) {
        return Scholars.fromJson(response.data);
      }

      throw _createDioException(
          'Failed to retrieve scholars', response.statusCode);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Unexpected error while retrieving scholars: $e');
    }
  }

  /// Gets scholar details by author name
  ///
  /// [author] - The name of the author to search for
  /// Returns a [ScholarDetail] object containing the scholar's information
  /// Throws exceptions for network errors or failed requests
  Future<ScholarDetail> getScholarByName(String author) async {
    try {
      final Response response = await _dio.get(
        _authorByNameEndpoint,
        queryParameters: {'author': author},
      );

      if (response.statusCode == 200) {
        return ScholarDetail.fromJson(response.data);
      }

      throw _createDioException(
          'Failed to retrieve scholar by name', response.statusCode);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Error fetching scholar by name: $e');
    }
  }

  Future<ScholarDetail> getScholarDetail(String id) async {
    try {
      final Response response = await _dio.get('$_authorDetailEndpoint$id');

      if (response.statusCode == 200) {
        return ScholarDetail.fromJson(response.data);
      }

      throw _createDioException(
          'Failed to retrieve scholar details', response.statusCode);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Error fetching scholar detail: $e');
    }
  }

  Future<PubDetail> getPubDetail(String name) async {
    try {
      final Response response = await _dio.get('$_pubDetailEndpoint$name');

      if (response.statusCode == 200) {
        return PubDetail.fromJson(response.data);
      }

      throw _createDioException(
          'Failed to retrieve publication detail', response.statusCode);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw Exception('Error fetching publication detail: $e');
    }
  }

  /// Creates a standardized DioException with meaningful error message
  DioException _createDioException(String message, int? statusCode) {
    return DioException(
      requestOptions: RequestOptions(path: ''),
      error: '$message${statusCode != null ? ': Status $statusCode' : ''}',
    );
  }

  /// Handles DioException instances with appropriate error messages
  Exception _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception(
        'Connection timed out. Please check your internet connection and try again.',
      );
    }

    return Exception('Network error: ${e.message}');
  }
}
