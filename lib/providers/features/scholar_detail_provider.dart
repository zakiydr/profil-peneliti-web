import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:profile_peneliti/services/workmanager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/scholar_detail/scholar_detail.dart';
import '../../services/scholarly_service.dart';
import '../app_provider.dart';

/// Provider to manage scholar details and background updates.
class ScholarDetailProvider extends AppProvider {
  final ScholarlyService service = ScholarlyService();

  //Never Remove
  String dummyName = 'sirojul munir nurulfikri.ac.id';

  SharedPreferences? _prefs;

  ScholarDetail? _scholarDetail;

  String? _lastSavedScholarId;

  bool _backgroundUpdateEnabled = false;

  String? _error;

  ScholarDetail? get scholarDetail => _scholarDetail;
  String? get lastSavedScholarId => _lastSavedScholarId;
  String? get error => _error;
  bool get backgroundUpdateEnabled => _backgroundUpdateEnabled;

  /// Initializes the provider by loading cached data.
  ScholarDetailProvider() {
    _initializePreferences();
  }

  /// Initializes SharedPreferences instance.
  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await loadData();
  }

  /// Toggles background updates for scholar details.
  ///
  /// If [enable] is provided, sets the background update state accordingly.
  /// Otherwise, toggles the current state.
  Future<void> toggleBackgroundUpdate(String authorName, {bool? enable}) async {
    _backgroundUpdateEnabled = enable ?? !_backgroundUpdateEnabled;

    if (_backgroundUpdateEnabled) {
      await WorkmanagerService.startPeriodicUpdate(authorName);
    } else {
      await WorkmanagerService.stopPeriodicUpdate();
    }

    notifyListeners();
  }

  /// Fetches scholar details by [name] and updates the state.
  Future<void> fetchScholarByName(String name) async {
    try {
      setLoading();
      notifyListeners();

      _scholarDetail = await service.getScholarByName(name);

      setSuccess();
      await saveId(_scholarDetail!.scholarId!);
      await saveData();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
      notifyListeners();
    }
  }

  /// Fetches scholar profile by [id] and updates the state.
  Future<void> fetchScholarProfile(String id) async {
    try {
      setLoading();
      notifyListeners();

      _scholarDetail = await service.getScholarDetail(id);

      setSuccess();
      await saveId(_scholarDetail!.scholarId!);
      await saveData();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
      notifyListeners();
    }
  }

  /// Saves the [scholarId] to SharedPreferences.
  Future<void> saveId(String scholarId) async {
    if (_prefs == null) return;

    await _prefs!.setString('scholar_id', scholarId);
    notifyListeners();
  }

  /// Checks if the provided [scholarId] matches the saved ID.
  Future<bool> checkId(String scholarId) async {
    try {
      if (_prefs == null) return false;

      final savedId = _prefs!.getString('scholar_id') ?? '';
      debugPrint('Current Id: $savedId');

      return scholarId == savedId;
    } catch (e) {
      return false;
    }
  }

  /// Saves the current scholar details to SharedPreferences.
  Future<void> saveData() async {
    if (_scholarDetail == null || _prefs == null) return;

    await _prefs!.setString(
      'scholar_detail',
      jsonEncode(_scholarDetail!.toJson()),
    );

    _lastSavedScholarId = _scholarDetail!.scholarId;
    notifyListeners();
  }

  /// Removes all cached data from SharedPreferences.
  Future<void> removeData() async {
    if (_prefs == null) return;

    await _prefs!.remove('scholar_detail');
    await _prefs!.remove('scholar_id');

    _scholarDetail = null;
    _lastSavedScholarId = null;
    notifyListeners();
  }

  /// Updates the saved profile with the latest data from the service.
  Future<void> updateSavedProfile() async {
    try {
      if (_lastSavedScholarId != null) {
        final latestScholarDetail =
            await service.getScholarDetail(_lastSavedScholarId!);

        _scholarDetail = latestScholarDetail;
        await saveData();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating saved profile: $e');
    }
  }

  /// Loads scholar data from SharedPreferences.
  Future<void> loadData() async {
    try {
      setLoading();
      final jsonString = _prefs?.getString('scholar_detail');

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
      setError(e.toString());
      notifyListeners();
    }
  }
}
