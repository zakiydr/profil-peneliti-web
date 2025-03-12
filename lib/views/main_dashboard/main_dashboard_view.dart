import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:profile_peneliti/constants/app_routes.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/widgets/app_fa_icon.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/features/dashboard_menu_provider.dart';
import '../../providers/features/scholar_detail_provider.dart';
import '../../utils/responsive.dart';
import '../../widgets/dashboard_menu/dashboard_menu.dart';
import '../../widgets/header.dart';
import 'main_dashboard_init.dart';

class MainDashboardView extends StatelessWidget {
  const MainDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final scholar = context.read<ScholarDetailProvider>();
    final auth = context.read<GoogleAuthProvider>();
    return Scaffold(
      drawer: const DashboardMenu(),
      floatingActionButton: _buildFloatingButton(context, scholar),
      body: Consumer<ScholarDetailProvider>(
        builder: (context, scholar, child) {
          switch (scholar.state) {
            case LoadingStates.initial:
              return Container();
            case LoadingStates.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadingStates.success:
              return _buildBody(context);
            case LoadingStates.error:
              return _buildError();
            default:
              return Container();
          }
        },
      ),
    );
  }

  Center _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Unexpected error'),
          // ElevatedButton(
          //     onPressed: () async {
          //       if (scholar.scholarDetail != null) {
          //         Navigator.pushReplacementNamed(
          //             context, AppRoutes.dashboard);
          //       } else {
          //         await auth.logout();
          //         Navigator.pushReplacementNamed(
          //             context, AppRoutes.login);
          //       }
          //     },
          //     child: const Text('Back'))
        ],
      ),
    );
  }

  Widget _buildFloatingButton(
      BuildContext context, ScholarDetailProvider scholar) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            scholar.scholarDetail?.scholarId !=
                snapshot.data?.getString('scholar_id')) {
          return FloatingActionButton(
            child: const AppFaIcon(FontAwesomeIcons.house),
            onPressed: () {},
          );
        }
        return Container();
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final menu = Provider.of<DashboardMenuProvider>(context);
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ResponsiveConfig.getDeviceType(context) == DeviceType.desktop)
            Expanded(
              flex: 1,
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(16),
                child: DashboardMenu(),
              ),
            ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                const AppHeader(),
                Expanded(
                  child: menu.pages[menu.selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
