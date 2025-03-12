// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';

class ArticlesDetailCard extends StatelessWidget {
  final String? title;
  final String? topSubtitle;
  final String? bottomSubtitle;
  final String? leadingCitation;
  final bool? isCompact;
  final List<Widget>? detail;
  final VoidCallback? onTap;

  const ArticlesDetailCard({
    Key? key,
    this.title,
    this.topSubtitle,
    this.bottomSubtitle,
    this.leadingCitation,
    this.isCompact = false,
    this.onTap,
    this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      elevation: 4,
      child: ListTile(
          leading: Column(
            children: [
              Text(
                leadingCitation ?? '',
                style:
                    isCompact! ? textTheme.titleMedium : textTheme.titleMedium,
              ),
              Text(
                'Citations',
                style:
                    isCompact! ? textTheme.labelMedium : textTheme.labelMedium,
              )
            ],
          ),
          title: Text(title ?? '',
              style:
                  isCompact! ? textTheme.titleMedium : textTheme.titleMedium),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                topSubtitle ?? '',
                style:
                    isCompact! ? textTheme.labelMedium : textTheme.labelMedium!,
              ),
              Text(
                bottomSubtitle ?? '',
                style:
                    isCompact! ? textTheme.labelMedium : textTheme.labelMedium,
              ),
            ],
          ),
          trailing: IconButton(
            icon: AppFaIcon(FontAwesomeIcons.upRightFromSquare),
            onPressed: () {
              showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    content: Column(children: detail ?? []),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          onTap: onTap ?? () {}),
    );
  }
}
