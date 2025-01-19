import 'package:profile_peneliti/models/scholar_detail/scholar_detail.dart';
import 'package:profile_peneliti/services/scholar_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      ScholarService scholarService = ScholarService();
      final prefs = await SharedPreferences.getInstance();

      final scholarId = prefs.getString('scholar_id');

      try {
        ScholarDetail detail =
            await scholarService.getScholarDetail(scholarId!);
        // You can handle the fetched data here, such as storing it locally
        print('Background Task: Scholar Detail fetched successfully.');
      } catch (e) {
        print('Background Task Error: $e');
      }

      return Future.value(true);
    });
  }
}
