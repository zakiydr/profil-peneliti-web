import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/scholar_detail/scholar_detail.dart';
import '../app_provider.dart';

class PublicationProvider extends AppProvider {
  ScholarDetail? _scholarDetail;

  void setScholarDetail(ScholarDetail? scholarDetail) {
    _scholarDetail = scholarDetail;
  }

  Future<void> savePubCitations() async {
    if (_scholarDetail == null) return;

    final prefs = await SharedPreferences.getInstance();

    final Map<String, int> savedPublicationCitations = {};

    for (var publication in _scholarDetail!.publications ?? []) {
      if (publication.authorPubId != null) {
        savedPublicationCitations[publication.authorPubId!] =
            publication.numCitations ?? 0;
      }
    }

    final pubCitationsJson = jsonEncode(savedPublicationCitations);

    await prefs.setString('pub_citations', pubCitationsJson);

    debugPrint('Saved publication citations: $pubCitationsJson');
    notifyListeners();
  }

  Future<int> comparePublicationCitations() async {
    if (_scholarDetail == null) return 0;

    final prefs = await SharedPreferences.getInstance();
    final savedPubCitationsJson = prefs.getString('pub_citations');

    if (savedPubCitationsJson == null) {
      return 0;
    }

    final Map<String, dynamic> savedPublicationCitations =
        Map<String, dynamic>.from(jsonDecode(savedPubCitationsJson));

    int totalCitationChange = 0;

    for (var publication in _scholarDetail!.publications ?? []) {
      if (publication.authorPubId != null) {
        final int savedCitations =
            savedPublicationCitations[publication.authorPubId] ?? 0;
        final int currentCitations = publication.numCitations ?? 0;

        if (savedCitations != currentCitations) {
          totalCitationChange += (currentCitations - savedCitations);
        }
      }
    }

    return totalCitationChange > 0 ? totalCitationChange : 0;
  }

  // Add a new method to get changed publications
  Future<List<Publication>> getChangedPublications() async {
    if (_scholarDetail == null) return [];

    final prefs = await SharedPreferences.getInstance();
    final savedPubCitationsJson = prefs.getString('pub_citations');

    if (savedPubCitationsJson == null) {
      return [];
    }

    final Map<String, dynamic> savedPublicationCitations =
        Map<String, dynamic>.from(jsonDecode(savedPubCitationsJson));

    List<Publication> changedPublications = [];

    for (var publication in _scholarDetail!.publications ?? []) {
      if (publication.authorPubId != null) {
        final savedCitations =
            savedPublicationCitations[publication.authorPubId] ?? 0;
        final currentCitations = publication.numCitations ?? 0;

        if (savedCitations != currentCitations) {
          changedPublications.add(publication);
        }
      }
    }

    return changedPublications;
  }
}
