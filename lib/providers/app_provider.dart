import 'package:flutter/material.dart';

enum LoadingStates { initial, loading, empty, success, error }

abstract class AppProvider extends ChangeNotifier {
  LoadingStates _state = LoadingStates.initial;
  String? _errorMessage;

  LoadingStates get state => _state;
  String? get errorMessage => _errorMessage;

  void setInitial() {
    _state = LoadingStates.initial;
  }

  void setLoading() {
    _state = LoadingStates.loading;
  }

  void setSuccess() {
    _state = LoadingStates.success;
  }

  void setEmpty() {
    _state = LoadingStates.empty;
  }

  void setError(String message) {
    _state = LoadingStates.error;
    _errorMessage = message;
  }
}
