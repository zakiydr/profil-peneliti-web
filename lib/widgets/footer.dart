import 'package:flutter/material.dart';
import 'package:profile_peneliti/theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: AppColors.lightGrey,
      title:
          Text('2025 \u00a9 STT Terpadu Nurul Fikri', style: style.titleSmall),
      trailing: Image.asset(
        'assets/images/logo-sttnf.png',
      ),
    );
  }
}
