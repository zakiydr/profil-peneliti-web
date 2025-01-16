// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/features/scholars_provider.dart';

class SearchInit extends StatefulWidget {
  final Widget child;

  const SearchInit({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<SearchInit> createState() => _SearchInitState();
}

class _SearchInitState extends State<SearchInit> {
  late ScholarsProvider _searchProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _searchProvider = context.read<ScholarsProvider>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchProvider = context.read<ScholarsProvider>();

      // Directly request focus if the flag is set
      if (searchProvider.shouldFocusSearchField) {
        searchProvider.searchFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
