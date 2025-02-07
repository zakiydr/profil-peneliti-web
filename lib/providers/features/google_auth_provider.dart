import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:profile_peneliti/services/google_auth_service.dart';

class GoogleAuthProvider extends AppProvider {
  GoogleAuthService googleService = GoogleAuthService();

  final dummyUser = 'sirojul munir nurulfikri.ac.id';

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

// In GoogleAuthProvider
  Future<GoogleSignInAccount?> login(BuildContext context) async {
    try {
      final user = await googleService.signIn();
      if (user == null) {
        // ScaffoldMessenger.of(context).showSnackBar(...);
        return null;
      }
      _user = user;
      notifyListeners();
      Navigator.of(context).pushReplacementNamed('/search');
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      return null;
    }
  }

  Future<GoogleSignInAccount?> logout() => googleService.signOut();
}
