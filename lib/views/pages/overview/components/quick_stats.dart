import 'package:flutter/material.dart';
import '../../../../../utils/responsive.dart';
import 'quick_stats_card.dart';

class QuickStatsWidget extends StatelessWidget {
  final double childAspectRatio;
  final int crossAxisCount;
  final List<QuickStatsCard> children;

  const QuickStatsWidget({
    Key? key,
    required this.childAspectRatio,
    required this.crossAxisCount,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveConfig.getDeviceType(context);

    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 32,
      childAspectRatio: deviceType == DeviceType.desktop
          ? childAspectRatio * 1.5
          : deviceType == DeviceType.tablet
              ? childAspectRatio * 0.8
              : childAspectRatio,
      crossAxisCount: deviceType == DeviceType.mobile ? 2 : crossAxisCount,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}
