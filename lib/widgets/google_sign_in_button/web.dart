// web.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';
import 'package:google_sign_in_web/web_only.dart' as web;

Widget buildSignInButton(BuildContext context) {
  return web.renderButton(
      configuration: GSIButtonConfiguration(type: GSIButtonType.standard));
}
