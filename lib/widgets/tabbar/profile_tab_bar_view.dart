import 'package:flutter/material.dart';

class ProfileTabBarView extends StatelessWidget {
  final Widget article;
  final Widget citedBy;
  final Widget coAuthors;
  final TabController controller;
  const ProfileTabBarView(
      {super.key,
      required this.article,
      required this.citedBy,
      required this.coAuthors,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          article,
          citedBy,
          coAuthors,
        ],
      ),
    );
  }
}
