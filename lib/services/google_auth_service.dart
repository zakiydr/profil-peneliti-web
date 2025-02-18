import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthService {
  static const webClientId =
      '64704630333-psg3e4optpnekg30729in9k322loc7af.apps.googleusercontent.com';
  static const _scopes = ['email', 'profile'];
  static const _keyIsSignedIn = 'is_signed_in';

  late final GoogleSignIn _googleSignIn;
  final _prefs = SharedPreferences.getInstance();

  GoogleAuthService() {
    _googleSignIn = GoogleSignIn(
      clientId: kIsWeb ? webClientId : null,
      scopes: _scopes,
    );
    _initializeSignInState();
  }

  Future<void> _initializeSignInState() async {
    final prefs = await _prefs;
    if (prefs.getBool(_keyIsSignedIn) ?? false) {
      await signInSilently();
    }
  }

  Stream<GoogleSignInAccount?> get onCurrentUserChanged =>
      _googleSignIn.onCurrentUserChanged;

  Future<GoogleSignInAccount?> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account != null) {
      final prefs = await _prefs;
      await prefs.setBool(_keyIsSignedIn, true);
    }
    return account;
  }

  Future<GoogleSignInAccount?> signOut() async {
    final prefs = await _prefs;
    await prefs.setBool(_keyIsSignedIn, false);
    return _googleSignIn.disconnect();
  }

  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      if (account != null) {
        final prefs = await _prefs;
        await prefs.setBool(_keyIsSignedIn, true);
      }
      return account;
    } catch (e) {
      print('Silent sign in failed: $e');
      return null;
    }
  }

  Future<bool> canAccessScopes() => _googleSignIn.canAccessScopes(_scopes);
  Future<bool> requestScopes() => _googleSignIn.requestScopes(_scopes);
}