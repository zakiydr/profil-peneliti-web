// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/features/scholar_detail_provider.dart';

class ArticlesInit extends StatefulWidget {
  final Widget? child;
  const ArticlesInit({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  State<ArticlesInit> createState() => _ArticlesInitState();
}

class _ArticlesInitState extends State<ArticlesInit> {
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    if (!mounted) return;

    await context.read<ScholarDetailProvider>().loadData();

    // if (context.read<ScholarDetailProvider>().scholarDetail == null) {
    //   Navigator.of(context).pushReplacementNamed('/');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
