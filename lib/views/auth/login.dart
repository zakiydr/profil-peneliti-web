// sign_in.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:profile_peneliti/constants/app_images.dart';
import 'package:profile_peneliti/extension/string_extension.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/utils/responsive.dart';
import 'package:profile_peneliti/widgets/google_sign_in_button/google_sign_in_button.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<GoogleAuthProvider>();
    final scholarly = context.read<ScholarDetailProvider>();
    final citation = context.read<CitationProvider>();
    final user = context.watch<GoogleAuthProvider>().user;
    final textTheme = Theme.of(context).textTheme;

    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.loginRedirect);
      });
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop)
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: ExactAssetImage(AppImages.webBackground),
                      fit: BoxFit.cover)),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
              ),
            ),
          Center(
            child: SizedBox(
              width: 700,
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        style: textTheme.headlineSmall,
                      ),
                      const Image(
                        width: 100,
                        image: AssetImage(
                          'assets/images/icon_app.png',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      buildSignInButton(context),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       final name = 'sirojul munir nurulfikri.ac.id';

                      //       scholarly.fetchScholarByName(name);
                      //       scholarly.saveData();
                      //       scholarly.saveId(
                      //           scholarly.scholarDetail!.scholarId.toString());
                      //       citation.saveCitation(scholarly.scholarDetail!.citedby);

                      //       Navigator.pushReplacementNamed(context, '/dashboard');
                      //     },
                      //     child: Text('dummy Login'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
