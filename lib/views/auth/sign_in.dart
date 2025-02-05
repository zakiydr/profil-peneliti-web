import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/services/google_login_service.dart';
import 'package:profile_peneliti/views/auth/success.dart';
import 'package:profile_peneliti/views/search/search_view.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final googleAuth = context.read<GoogleAuthProvider>();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    googleAuth.login(context);
                  },
                  child: Text('Sign in with Google')),
            ),
          ),
        ],
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
