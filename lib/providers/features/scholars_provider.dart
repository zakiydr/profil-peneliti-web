import 'package:flutter/material.dart';

import '../../models/scholars/scholars.dart';
import '../../services/scholarly_service.dart';
import '../app_provider.dart';

class ScholarsProvider extends AppProvider {
  final ScholarlyService service = ScholarlyService();

  Scholars? _scholars;
  final bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  bool _shouldFocusSearchField = false;

  Scholars? get scholars => _scholars;
  bool get isLoading => _isLoading;
  TextEditingController get searchController => _searchController;
  FocusNode get searchFocusNode => _searchFocusNode;

  bool get shouldFocusSearchField => _shouldFocusSearchField;

  void setShouldFocusSearchField(bool value) {
    _shouldFocusSearchField = value;
    notifyListeners();
  }

  void resetSearch() {
    _scholars = null;
    _searchController.clear();
    setInitial();
    notifyListeners();
  }

  void prepareForSearch() {
    _scholars = null;
    _searchController.clear();

    _shouldFocusSearchField = true;

    setInitial();
    notifyListeners();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> fetchScholars(author) async {
    setLoading();
    notifyListeners();
    debugPrint('Retrieving data...');
    try {
      // _scholars = await service.getScholars(author, page, limit);
      _scholars = await service.getScholars(author);
      if (scholars!.authors!.isEmpty) {
        setEmpty();
        notifyListeners();
        debugPrint('No data found');
      } else {
        setSuccess();
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
      notifyListeners();
      debugPrint('Unexpected error');
      throw Exception(e);
    }
    notifyListeners();
  }
}
