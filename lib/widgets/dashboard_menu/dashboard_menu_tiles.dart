// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DashboardTiles extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final VoidCallback? onTap;
  final bool selected;
  const DashboardTiles({
    Key? key,
    this.leading,
    this.title,
    this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      selected: selected,
      title: Text(title ?? ''),
      onTap: onTap,
    );
  }
}
