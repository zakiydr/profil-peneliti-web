import 'package:flutter/material.dart';

import '../../../../utils/responsive.dart';

class QuickStatsCard extends StatelessWidget {
  final String title;
  final String content;
  const QuickStatsCard({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveConfig.getPadding(context);
    final style = Theme.of(context).textTheme;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: style.titleMedium,
                ),
              ],
            ),
            Text(
              content,
              style: style.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
