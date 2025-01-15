import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_provider.dart';

class NotificationProvider extends AppProvider {
  final _channel = const MethodChannel('app_badger');

  Future<void> setBadge(int count) async {
    try {
      await _channel.invokeMethod('setBadge', {'count': count});
    } catch (e) {
      debugPrint("Failed to set badge: '${e.toString()}'.");
    }
  }

  /// Removes the app's badge.
  Future<void> removeBadge() async {
    try {
      await _channel.invokeMethod('removeBadge');
    } on PlatformException catch (e) {
      print("Failed to remove badge: '${e.message}'.");
    }
  }
}
