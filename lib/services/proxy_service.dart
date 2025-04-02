import 'package:dio/dio.dart';

class ProxyService {
  static const _url = 'https://kscien-scraper.up.railway.app/';

  // Singleton pattern to ensure only one instance exists
  static final ProxyService _instance = ProxyService._internal();

  factory ProxyService() {
    return _instance;
  }

  ProxyService._internal() {
    _initDio();
  }

  late final Dio dio;

  void _initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: _url,
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
        // Add some headers if needed
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging or other purposes
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  Future<Response> setProxy() async {
    try {
      final Response response = await dio.post('use-freeproxies');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Proxy set successfully: ${response.data}');
        return response;
      }

      throw Exception(
          'Failed to set proxy. Status code: ${response.statusCode}');
    } on DioException catch (e) {
      print('DioException when setting proxy: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status code: ${e.response?.statusCode}');
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      print('Error setting proxy: $e');
      throw Exception('Error setting proxy: $e');
    }
  }
}
