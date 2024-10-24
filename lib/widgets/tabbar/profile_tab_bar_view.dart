import 'package:flutter/material.dart';

class ProfileTabBarView extends StatelessWidget {
  final Widget articles;
  final Widget citedBy;
  final Widget coAuthors;
  final TabController controller;
  const ProfileTabBarView(
      {super.key,
      required this.articles,
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
          articles,
          citedBy,
          coAuthors,
        ],
      ),
    );
  }
}
