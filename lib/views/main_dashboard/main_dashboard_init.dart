import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/services/workmanager_service.dart';
import 'package:profile_peneliti/views/main_dashboard/main_dashboard_view.dart';
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
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _scholarProvider =
  //       Provider.of<ScholarDetailProvider>(context, listen: false);
  // }

  @override
  void initState() {
    super.initState();
    final scholarly = context.read<ScholarDetailProvider>();
    _askPermission();
    // if (!kIsWeb) {
    //   WorkmanagerService.startPeriodicUpdate(
    //       scholarly.scholarDetail?.name ?? '');
    // }
    // final publication =
    //     Provider.of<PublicationProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   publication.setScholarDetail(_scholarProvider.scholarDetail);

    //   _initializeData();
    // });
  }

  Future<void> _askPermission() async {
    print("Requesting notification permission...");
    PermissionStatus notificationStatus =
        await Permission.notification.request();
    print("Permission Status: $notificationStatus");

    if (notificationStatus == PermissionStatus.granted) {}
    if (notificationStatus == PermissionStatus.denied) {}
    if (notificationStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  // Future<void> _initializeData() async {
  //   if (!mounted) return;

  //   final scholar = Provider.of<ScholarDetailProvider>(context, listen: false);
  //   // publication.setScholarDetail(scholar.scholarDetail);
  //   if (scholar.scholarDetail == null) {
  //     Navigator.of(context).pushReplacementNamed('/search');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const MainDashboardView();
  }
}
