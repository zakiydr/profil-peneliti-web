  import 'package:flutter/services.dart';

import '../app_provider.dart';

class NotificationProvider extends AppProvider {
  static const platform = MethodChannel('app.badger');

  int _badgeCount = 0;

  Future<void> setBadge(int count) async {
    try {
      await platform.invokeMethod('setBadge', {'count': count});
      _badgeCount = count;
      notifyListeners();
    } on PlatformException catch (e) {
      print("Failed to set badge: '${e.message}'.");
      // Optionally, handle MIUI permission request
      if (e.code == 'UNAVAILABLE') {
        // Show a prompt to the user to grant permissions
      }
    }
  }

  Future<void> clearBadge() async {
    try {
      await platform.invokeMethod('clearBadge');
      _badgeCount = 0;
      notifyListeners();
    } on PlatformException catch (e) {
      print("Failed to clear badge: '${e.message}'.");
    }
  }

  Future<void> requestMIUIPermissions() async {
  try {
    await platform.invokeMethod('requestMIUIPermission');
  } on PlatformException catch (e) {
    print("Failed to request MIUI permissions: '${e.message}'.");
  }
}


  int get badgeCount => _badgeCount;
}
