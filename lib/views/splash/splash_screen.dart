import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:profile_peneliti/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../../providers/features/scholar_detail_provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkInitialRoute();
    });
  }

  Future<void> _checkInitialRoute() async {
    // Add null check and mount check
    if (!mounted) return;

    try {
      // Use Provider.of with listen: false to avoid potential issues
      final scholarProvider =
          Provider.of<ScholarDetailProvider>(context, listen: false);

      await scholarProvider.loadData();

      if (!mounted) return;

      if (scholarProvider.scholarDetail != null) {
        // Navigator.pushReplacementNamed(context, '/auth');
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        // Navigator.pushReplacementNamed(context, '/auth');
        Navigator.pushReplacementNamed(context, '/search');
      }
    } catch (e) {
      debugPrint('Error during initialization: $e');
      if (mounted) {
        // Navigator.pushReplacementNamed(context, '/auth');
        Navigator.pushReplacementNamed(context, '/search');
      }
    }
  }

  double getResponsiveSize(double size) {
    if (ResponsiveConfig.getDeviceType(context) == DeviceType.mobile) {
      return size;
    }
    if (ResponsiveConfig.getDeviceType(context) == DeviceType.tablet) {
      return size * 1.2;
    }
    return size * 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo-sttnf.png',
              width: getResponsiveSize(100),
            ),
            LoadingAnimationWidget.progressiveDots(
              color: Colors.blue,
              size: getResponsiveSize(50),
            )
          ],
        ),
      ),
    );
  }
}
