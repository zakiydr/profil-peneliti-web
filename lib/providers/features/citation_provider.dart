import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CitationProvider extends AppProvider {
  // final client = ScholarService();

  Future<void> saveCitation(value) async {
    // if (_scholarDetail == null) return;

    final prefs = await SharedPreferences.getInstance();

    final savedCitation = prefs.getInt('citation') ?? 0;
    final currentCitation = value;

    if (savedCitation != currentCitation) {
      await prefs.setInt('citation', currentCitation);
      notifyListeners();
    }
  }

  // Future<void> removeCitation() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   if (!prefs.containsKey('citation')) {
  //     print('No data exist');
  //   }
  //   await prefs.remove
  // }

  Future<int> compareTotalCitation(
      int totalCitation, String currentScholarId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Retrieve the saved scholar ID and citation count
      final savedCitation = prefs.getInt('citation') ?? 0;
      final savedScholarId = prefs.getString('scholar_id') ?? '';

      debugPrint('Comparing Citations:');
      debugPrint('Saved Scholar ID: $savedScholarId');
      debugPrint('Current Scholar ID: $currentScholarId');
      debugPrint('Saved Citation: $savedCitation');
      debugPrint('Current Total Citation: $totalCitation');

      // Check if the current scholar ID matches the saved scholar ID
      if (currentScholarId != savedScholarId) {
        // Log that IDs are different but do not reset the saved citation
        debugPrint('IDs are different. No action taken.');
        return 0; // Return 0 to indicate no notification since IDs do not match
      }

      // Calculate the notification difference if IDs match
      final notification = totalCitation - savedCitation;
      debugPrint('Notification Difference: $notification');

      return notification > 0 ? notification : 0;
    } catch (e) {
      debugPrint('Error in compareTotalCitation: $e');
      return 0;
    }
  }
}
