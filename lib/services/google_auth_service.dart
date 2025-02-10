import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static const webClientId =
      '64704630333-psg3e4optpnekg30729in9k322loc7af.apps.googleusercontent.com';
  static const _scopes = ['email', 'profile'];

  late final GoogleSignIn _googleSignIn;

  GoogleAuthService() {
    _googleSignIn = GoogleSignIn(
      clientId: kIsWeb ? webClientId : null,
      scopes: _scopes,
    );
  }

  Stream<GoogleSignInAccount?> get onCurrentUserChanged =>
      _googleSignIn.onCurrentUserChanged;

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
  Future<GoogleSignInAccount?> signOut() => _googleSignIn.disconnect();
  Future<GoogleSignInAccount?> signInSilently() =>
      _googleSignIn.signInSilently();
  Future<bool> canAccessScopes() => _googleSignIn.canAccessScopes(_scopes);
  Future<bool> requestScopes() => _googleSignIn.requestScopes(_scopes);
}
