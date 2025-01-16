import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:provider/provider.dart';

class MainDashboardInit extends StatefulWidget {
  final Widget? child;

  const MainDashboardInit({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  State<MainDashboardInit> createState() => _MainDashboardInitState();
}

class _MainDashboardInitState extends State<MainDashboardInit> {
  late ScholarDetailProvider _scholarProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scholarProvider =
        Provider.of<ScholarDetailProvider>(context, listen: false);
  }

  @override
  void initState() {
    super.initState();
    final publication =
        Provider.of<PublicationProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      publication.setScholarDetail(_scholarProvider.scholarDetail);

      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    if (!mounted) return;

    final scholar = Provider.of<ScholarDetailProvider>(context, listen: false);
    // publication.setScholarDetail(scholar.scholarDetail);
    if (scholar.scholarDetail == null) {
      Navigator.of(context).pushReplacementNamed('/search');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
