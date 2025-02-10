// web.dart
import 'package:flutter/widgets.dart';
import 'package:google_sign_in_web/web_only.dart' as web;

Widget buildSignInButton(BuildContext context) {
  return web.renderButton(); // Renders the web-specific Google Sign-In button
}
