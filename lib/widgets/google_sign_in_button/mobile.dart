// mobile.dart
import 'package:flutter/material.dart';
import 'package:profile_peneliti/extension/email_parsing.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

Widget buildSignInButton(BuildContext context) {
  final auth = context.read<GoogleAuthProvider>();
  final scholarly = context.read<ScholarDetailProvider>();
  final citation = context.read<CitationProvider>();
  return SignInButton(
    Buttons.google,
    onPressed: () async {
      await auth.login();
      // Navigator.pushReplacementNamed(context, '/dashboard');
      // await scholarly.fetchScholarByName(scholarly.dummyName);

      // // scholarly.fetchScholarByName(
      // //     '${auth.user!.displayName} ${auth.user!.email.splitDomain()}');
      // scholarly.saveData();
      // scholarly.saveId(scholarly.scholarDetail!.scholarId.toString());
      // citation.saveCitation(scholarly.scholarDetail!.citedby);
    },
    elevation: 4,
    // child: const Text('Sign in with Google'),
  );
}
