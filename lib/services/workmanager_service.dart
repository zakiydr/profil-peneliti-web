// // lib/services/workmanager_service.dart

// import 'package:workmanager/workmanager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'scholarly_service.dart';

// /// Unique identifier for the scholar update task.
// const String scholarUpdateTask = "com.example.gsprofile.scholarlyUpdate";

// /// Callback dispatcher that handles background tasks.
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     if (task == scholarUpdateTask) {
//       try {
//         final service = ScholarlyService();
//         final prefs = await SharedPreferences.getInstance();

//         final authorName = prefs.getString('tracked_author');
//         if (authorName == null) {
//           // No author is being tracked, nothing to do.
//           return Future.value(true);
//         }

//         // Fetch updated scholar details.
//         await service.getScholarByName(authorName);

//         // Save the updated scholar details.
//         // await prefs.setString(
//         //   'scholar_detail',
//         //   jsonEncode(scholarDetail.toJson()),
//         // );

//         // Optionally, send a notification about the update.
//         // await NotificationService.showNotification(
//         //   title: "Scholar Updated",
//         //   body: "Details for $authorName have been updated.",
//         // );

//         print('Success');

//         return Future.value(true);
//       } catch (e) {
//         print('Background task failed: $e');
//         return Future.value(false);
//       }
//     }
//     // Handle other task types if necessary.
//     return Future.value(true);
//   });
// }

// /// Service class to handle Workmanager related operations.
// class WorkmanagerService {
//   /// Initializes Workmanager with the callback dispatcher.
//   static Future<void> initialize() async {
//     await Workmanager().initialize(
//       callbackDispatcher,
//       isInDebugMode: true, // Set to false in production
//     );
//   }

//   /// Starts a periodic background task to update scholar details.
//   static Future<void> startPeriodicUpdate(String authorName) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('tracked_author', authorName);

//     await Workmanager().registerPeriodicTask(
//       scholarUpdateTask, // Unique name
//       scholarUpdateTask, // Task name
//       frequency: const Duration(minutes: 2), // Minimum allowed
//       constraints: Constraints(
//         networkType: NetworkType.connected,
//         requiresBatteryNotLow: true,
//       ),
//       existingWorkPolicy: ExistingWorkPolicy.replace,
//     );
//   }

//   /// Stops the periodic background task.
//   static Future<void> stopPeriodicUpdate() async {
//     await Workmanager().cancelByUniqueName(scholarUpdateTask);

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('tracked_author');
//   }
// }
