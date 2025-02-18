import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:profile_peneliti/utils/responsive.dart';

class QuickStatsCard extends StatelessWidget {
  final String title;
  final String content;
  final Color? color;

  final String img;
  const QuickStatsCard({
    Key? key,
    required this.title,
    required this.content,
    this.color,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = ResponsiveConfig.getPadding(context);
    final style = Theme.of(context).textTheme;
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            SvgPicture.asset(
              img,
              fit: BoxFit.fill,
              // colorFilter: ColorFilter.mode(color, BlendMode.colorDodge),
            ),
            Container(
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: style.titleLarge,
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
          ],
        ));
  }
}
