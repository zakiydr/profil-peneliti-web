// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/services/google_login_service.dart';
import 'package:profile_peneliti/views/auth/sign_in.dart';

class LoginSuccess extends StatelessWidget {
  final GoogleSignInAccount user;
  const LoginSuccess({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future signOut() async {
      final user = await GoogleSignInService.logout();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(),
          ));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(user.photoUrl!),
            Text(user.displayName!),
            Text(user.email),
            Text(user.id),
            Container(
              child: Center(
                child:
                    ElevatedButton(onPressed: signOut, child: Text('Sign out')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
