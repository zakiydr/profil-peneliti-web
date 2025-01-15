import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/scholar_detail/scholar_detail.dart';
import '../app_provider.dart';

class CitationProvider extends AppProvider {
  // final client = ScholarService();

  ScholarDetail? _scholarDetail;

  Future<void> saveCitation(int value) async {
    // if (_scholarDetail == null) return;

    final prefs = await SharedPreferences.getInstance();

    final savedCitation = prefs.getInt('citation') ?? 0;
    final currentCitation = value;

    if (savedCitation != currentCitation) {
      await prefs.setInt('citation', currentCitation);
      notifyListeners();
    }
  }

  Future<int> compareTotalCitation(int totalCitation) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Retrieve saved citation, default to 0 if not exists
      final savedCitation = prefs.getInt('citation') ?? 0;

      debugPrint('Comparing Citations:');
      debugPrint('Saved Citation: $savedCitation');
      debugPrint('Current Total Citation: $totalCitation');

      final notification = totalCitation - savedCitation;

      debugPrint('Notification Difference: $notification');

      // if (notification > 0) {
      //   await prefs.setInt('citation', totalCitation);
      //   notifyListeners();
      //   print('Citation updated with new total: $totalCitation');
      // }

      // FlutterAppBadge.count(notification);

      return notification > 0 ? notification : 0;
    } catch (e) {
      debugPrint('Error in compareTotalCitation: $e');
      return 0;
    }
  }
}
