import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/scholar_detail/scholar_detail.dart';
import '../../services/scholarly_service.dart';
import '../app_provider.dart';

class ScholarDetailProvider extends AppProvider {
  final ScholarlyService service = ScholarlyService();

  // Scholar

  ScholarDetail? _scholarDetail;
  String? _error;
  String? _lastSavedScholarId;

  ScholarDetail? get scholarDetail => _scholarDetail;
  String? get lastSavedScholarId => _lastSavedScholarId;
  String? get error => _error;

  Future<void> fetchScholarByName(String name) async {
    try {
      setLoading();
      notifyListeners();

      _scholarDetail = await service.getScholarByName(name);

      setSuccess();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> fetchScholarProfile(id) async {
    try {
      setLoading();
      notifyListeners();

      _scholarDetail = await service.getScholarDetail(id);

      setSuccess();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
      notifyListeners();
    }
  }

  Future<void> saveId(String scholarId) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('scholar_id')) {
      await prefs.remove('scholar_id');
    }

    await prefs.setString('scholar_id', scholarId);

    notifyListeners();
  }

  Future<bool> checkId(String scholarId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedId = prefs.getString('scholar_id') ?? '';

      final id = scholarId;

      debugPrint('Current Id: $savedId');

      if (id != savedId) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> saveData() async {
    // if (_scholarDetail == null) return;

    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('scholar_detail')) {
      await prefs.remove('scholar_detail');
    }

    await prefs.setString(
        'scholar_detail', jsonEncode(_scholarDetail!.toJson()));

    _lastSavedScholarId = _scholarDetail!.scholarId;

    notifyListeners();
  }

  Future<void> updateSavedProfile() async {
    try {
      if (_lastSavedScholarId != null) {
        final latestScholarDetail =
            await service.getScholarDetail(_lastSavedScholarId.toString());

        _scholarDetail = latestScholarDetail;
        await saveData();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating saved profile: $e');
    }
  }

  Future<void> loadData() async {
    try {
      setLoading();
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('scholar_detail');

      if (jsonString != null) {
        _scholarDetail = ScholarDetail.fromJson(jsonDecode(jsonString));

        _lastSavedScholarId = _scholarDetail!.scholarId;
        setSuccess();
      } else {
        _scholarDetail = null;
        _lastSavedScholarId = null;
        setEmpty();
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      setError(e.toString());
      notifyListeners();
    }
  }
}
