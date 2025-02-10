// mobile.dart
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:provider/provider.dart';

Widget buildSignInButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () => context.read<GoogleAuthProvider>().login(),
    child: const Text('Sign in with Google'),
  );
}
