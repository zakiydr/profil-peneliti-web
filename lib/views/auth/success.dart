// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSuccess extends StatelessWidget {
  final GoogleSignInAccount user;
  const LoginSuccess({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(user.displayName!),
          Text(user.email),
          Text(user.id),
          Text(user.photoUrl!),
        ],
      ),
    );
  }
}
