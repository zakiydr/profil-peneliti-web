// web.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in_web/web_only.dart' as web;
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';

Widget buildSignInButton(BuildContext context) {
  final auth = context.read<GoogleAuthProvider>();
  final scholarly = context.read<ScholarDetailProvider>();
  final citation = context.read<CitationProvider>();

  return web.renderButton();
}
