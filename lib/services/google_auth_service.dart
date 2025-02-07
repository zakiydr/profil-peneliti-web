import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static final webClientId =
      '64704630333-psg3e4optpnekg30729in9k322loc7af.apps.googleusercontent.com';
  final _googleSignIn = GoogleSignIn(
    clientId: webClientId,
    scopes: ['email', 'profile'],
  );

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();
  Future<GoogleSignInAccount?> signOut() => _googleSignIn.disconnect();
}
