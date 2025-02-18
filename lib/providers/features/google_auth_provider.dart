import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:profile_peneliti/services/google_auth_service.dart';

class GoogleAuthProvider extends AppProvider {
  final GoogleAuthService _googleService;
  StreamSubscription? _userSubscription;
  GoogleSignInAccount? _user;
  bool _isInitialized = false;

  GoogleAuthProvider([GoogleAuthService? googleService])
      : _googleService = googleService ?? GoogleAuthService() {
    _initialize();
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    
    _userSubscription =
        _googleService.onCurrentUserChanged.listen(_handleUserChanged);
    
    // Try to restore the previous session
    final silentSignIn = await _googleService.signInSilently();
    if (silentSignIn != null) {
      _user = silentSignIn;
      notifyListeners();
    }
    
    _isInitialized = true;
  }

  GoogleSignInAccount? get user => _user;

  Future<void> _handleUserChanged(GoogleSignInAccount? user) async {
    if (user == null) {
      _user = null;
      notifyListeners();
      return;
    }

    if (kIsWeb && !(await _googleService.canAccessScopes())) {
      if (!(await _googleService.requestScopes())) {
        await _googleService.signOut();
        return;
      }
    }

    _user = user;
    notifyListeners();
  }

  Future<GoogleSignInAccount?> login() async {
    try {
      final account = await _googleService.signIn();
      return account;
    } catch (e) {
      print('Failed Sign in: $e');
      return null;
    }
  }

  Future<void> logout() async {
    await _googleService.signOut();
    _user = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}