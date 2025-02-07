import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/services/google_auth_service.dart';
import 'package:profile_peneliti/views/auth/success.dart';
import 'package:profile_peneliti/views/search/search_view.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final googleAuth = context.read<GoogleAuthProvider>();
    final scholarly = context.read<ScholarDetailProvider>();
    final citation = context.read<CitationProvider>();
    final publication = context.read<PublicationProvider>();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  googleAuth.login(context);
                },
                child: Text('Sign in with Google')),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/dashboard');

                  scholarly.fetchScholarByName(googleAuth.dummyUser);

                  await scholarly.saveData();
                  await scholarly
                      .saveId(scholarly.scholarDetail!.scholarId.toString());
                  await citation.saveCitation(
                      scholarly.scholarDetail!.citedby!.toInt() - 5);
                  await publication.savePubCitations();
                },
                child: Text('Sign in with dummy')),
          ],
        ),
      ),
    );
  }

  // Future signIn(BuildContext context, GoogleAuthProvider googleAuth) async {
  //   final user = await googleAuth.login();

  //   if (user == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Sign in failed'),
  //       ),
  //     );
  //   } else {
  //     Navigator.of(context).pushReplacementNamed('/search');
  //   }
  // }
}
