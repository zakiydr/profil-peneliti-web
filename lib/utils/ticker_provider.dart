// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:profile_peneliti/view_model/tab_bar_view_model.dart';
import 'package:provider/provider.dart';

class TickerProviderWrapper extends StatefulWidget {
  final Widget child;

  const TickerProviderWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<TickerProviderWrapper> createState() => _TickerProviderWrapperState();
}

class _TickerProviderWrapperState extends State<TickerProviderWrapper>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final provider = Provider.of<TabBarViewModel>(context, listen: false);
        provider.initialize(this);
      }
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
