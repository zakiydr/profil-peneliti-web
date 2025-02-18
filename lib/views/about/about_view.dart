import 'package:flutter/material.dart';
import 'package:profile_peneliti/constants/app_images.dart';
import 'package:profile_peneliti/utils/responsive.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    //
    final space = SizedBox(
      height: 20,
    );
    return ListView(
      padding: ResponsiveConfig.getPadding(context),
      shrinkWrap: true,
      children: [
        Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(AppImages.appIcon),
              height: 100,
              width: 100,
            ),
            Text(
              'Aplikasi ini didukung oleh:',
              style: textTheme.titleLarge,
            ),
            Image(
              image: AssetImage(AppImages.sttnfIcon),
              height: 100,
            ),
            Text(
              'STT Terpadu Nurul Fikri',
              style: textTheme.titleMedium,
            ),
            Text(
              'Kampus B2, Jl. Raya Lenteng Agung No.20-21, RT.4/RW.1, Srengseng Sawah, Kec. Jagakarsa, Jakarta Selatan,',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
