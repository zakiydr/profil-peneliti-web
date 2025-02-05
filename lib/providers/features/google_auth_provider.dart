import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:profile_peneliti/services/google_login_service.dart';

class GoogleAuthProvider extends AppProvider {
  GoogleAuthService googleService = GoogleAuthService();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future<GoogleSignInAccount?> login(BuildContext context) async {
    final user = await googleService.signIn();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed'),
        ),
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/search');
    }
    // notifyListeners();
    return _user = user;
  }

  Future<GoogleSignInAccount?> logout() => googleService.signOut();
}
