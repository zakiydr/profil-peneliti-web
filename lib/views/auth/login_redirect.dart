import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:profile_peneliti/constants/app_images.dart';
import 'package:profile_peneliti/extension/string_extension.dart';
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

    final name = '${auth.user?.displayName} ${auth.user?.email.splitDomain()}';

    auth.login();
    try {
      await scholarly.fetchScholarByName(scholarly.dummyName);
      scholarly.saveData();
      scholarly.saveId(scholarly.scholarDetail!.scholarId.toString());
      citation.saveCitation(scholarly.scholarDetail!.citedby);

      if (scholarly.scholarDetail != null) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
      }
    } catch (e) {
      await auth.logout();
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AppImages.appIcon),
              width: 100,
            ),
            LoadingAnimationWidget.waveDots(color: AppColors.blue, size: 50),
            const Text('Signing in...'),
          ],
        ),
      ),
    );
  }
}
