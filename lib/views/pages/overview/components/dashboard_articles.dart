// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:provider/provider.dart';

class MostCitedArticles extends StatelessWidget {
  final String? articleTitle;

  final String? author;

  final String? journal;

  final int itemCount;

  final Widget? Function(BuildContext, int) itemBuilder;

  const MostCitedArticles({
    Key? key,
    this.articleTitle,
    this.author,
    this.journal,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MostCitedArticlesHeader(textTheme: textTheme),
                Divider(),
                ListView.separated(
                  // padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: itemBuilder,
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MostCitedArticlesHeader extends StatelessWidget {
  const MostCitedArticlesHeader({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final menu = Provider.of<DashboardMenuProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Most Cited',
          style: textTheme.titleMedium,
        ),
        TextButton(
          child: Text('See All'),
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(textTheme.titleMedium),
          ),
          onPressed: () { 
            menu.goToArticles(context);
          },
        ),
      ],
    );
  }
}
