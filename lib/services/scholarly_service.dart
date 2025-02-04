import 'package:dio/dio.dart';
import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/models/scholars/scholars.dart';

class ScholarlyService {
  static const _baseUrl = 'https://zakiydr.pythonanywhere.com/';
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        'Content-Type': 'application/json',
        // 'Access-Control-Allow-Origin': _baseUrl
      },
      receiveTimeout: Duration(seconds: 30),
      connectTimeout: Duration(seconds: 30),
    ),
  );

  // Future<Scholars> getScholars(String author, int page, int limit) async {
  //   final queryParams = {
  //     "author": author,
  //     "page": page,
  //     "limit": limit,
  //   };
  //   try {
  //     final Response response =
  //         await dio.get('goscholar/search/', queryParameters: queryParams);
  //     if (response.statusCode == 200) {
  //       final Scholars data = Scholars.fromJson(response.data);
  //       print(data.toString());
  //       return data;
  //     }

  //     throw DioException(
  //       requestOptions: RequestOptions(path: ''),
  //       error: 'Failed to retrieve scholars: Status ${response.statusCode}',
  //     );
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       throw Exception(
  //           'Connection timed out. Please check your internet connection and try again.');
  //     }
  //     throw Exception('Failed to retrieve scholars: ${e.message}');
  //   } catch (e) {
  //     throw Exception('Unexpected error: $e');
  //   }
  // }

  Future<Scholars> getScholars(String author) async {
    final queryParams = {
      "author": author,
    };
    try {
      final Response response =
          await dio.get('goscholar/search/compact/', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final Scholars data = Scholars.fromJson(response.data);
        print(data.toString());
        return data;
      }

      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Failed to retrieve scholars: Status ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception(
            'Connection timed out. Please check your internet connection and try again.');
      }
      throw Exception('Failed to retrieve scholars: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<ScholarDetail> getScholarDetail(String id) async {
    try {
      final Response response = await dio.get('goscholar/author/$id');
      final ScholarDetail data = ScholarDetail.fromJson(response.data);
      if (response.statusCode == 200) {
        return data;
      }

      print(data.toString());
      throw Exception('Failed to retrieve information');
    } catch (e) {
      print('Error fetching scholar detail: $e');
      throw Exception(e);
    }
  }
}
