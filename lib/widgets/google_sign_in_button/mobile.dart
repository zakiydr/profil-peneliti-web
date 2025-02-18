// mobile.dart
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

Widget buildSignInButton(BuildContext context) {
  final auth = context.read<GoogleAuthProvider>();
  return SignInButton(
    Buttons.google,
    onPressed: () async {
    },
    elevation: 4,
  );
}
