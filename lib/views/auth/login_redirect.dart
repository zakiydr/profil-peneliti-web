import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:profile_peneliti/constants/app_images.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';

class LoginRedirect extends StatefulWidget {
  const LoginRedirect({super.key});

  @override
  State<LoginRedirect> createState() => _LoginRedirectState();
}

class _LoginRedirectState extends State<LoginRedirect> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
    super.initState();
  }

  void _initializeData() async {
    final scholarly = context.read<ScholarDetailProvider>();
    final citation = context.read<CitationProvider>();
    final auth = context.read<GoogleAuthProvider>();

    await scholarly.fetchScholarByName(scholarly.dummyName);
    scholarly.saveData();
    scholarly.saveId(scholarly.scholarDetail!.scholarId.toString());
    citation.saveCitation(scholarly.scholarDetail!.citedby);

    if (scholarly.scholarDetail != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(AppImages.appIcon),
              width: 100,
            ),
            LoadingAnimationWidget.waveDots(color: AppColors.blue, size: 50),
            Text('Signing in...'),
          ],
        ),
      ),
    );
  }
}
