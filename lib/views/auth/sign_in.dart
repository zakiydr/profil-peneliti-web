import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:profile_peneliti/services/google_login_service.dart';
import 'package:profile_peneliti/views/auth/success.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleSignInService _signInService = GoogleSignInService();

  Future signIn() async {
    final user = await GoogleSignInService.login();

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign in failed'),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginSuccess(user: user),
      ));
    }
  }

  Future signOut() async {
    final user = await GoogleSignInService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: ElevatedButton(
                  onPressed: signIn, child: Text('Sign in with Google')),
            ),
          ),
          Container(
            child: Center(
              child: ElevatedButton(onPressed: signOut, child: Text('Sign out')),
            ),
          ),
          Container(),
          Text(''),
          Text(''),
        ],
      ),
    );
  }
}
