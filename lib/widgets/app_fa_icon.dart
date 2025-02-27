import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppFaIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String? semanticLabel;
  final List<Shadow>? shadow;
  final double? size;
  final TextDirection? textDirection;

  const AppFaIcon(
    this.icon, {
    super.key,
    this.color,
    this.semanticLabel,
    this.shadow,
    this.size,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      icon,
      color: color,
      key: key,
      semanticLabel: semanticLabel,
      shadows: shadow,
      size: 24,
      textDirection: textDirection,
    );
  }
}
