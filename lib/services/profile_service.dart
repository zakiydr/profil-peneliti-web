import 'package:dio/dio.dart';
import 'package:profile_peneliti/models/scholar_detail.dart';

class ScholarService {
  final dio = Dio(
    BaseOptions(baseUrl: 'http://127.0.0.1:8000/'),
  );

  Future<ScholarDetail> getScholarDetail(String id) async {
    try {
      final response = await dio.get('/goscholar/author/$id');
      final data = ScholarDetail.fromJson(response.data);
      if (response.statusCode == 200) {
        return data;
      }

      throw Exception('Failed to retrieve information');
    } catch (e) {
      throw Exception(e);
    }
  }

  
}
