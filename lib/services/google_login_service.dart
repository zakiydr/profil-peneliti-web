import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
  Future<GoogleSignInAccount?> signOut() => _googleSignIn.disconnect();
}
