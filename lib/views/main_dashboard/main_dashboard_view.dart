import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/app_provider.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      drawer: DashboardMenu(),
      body: Consumer<ScholarDetailProvider>(
        builder: (context, scholar, child) {
          switch (scholar.state) {
            case LoadingStates.initial:
              return Container();
            case LoadingStates.loading:
              return Center(child: CircularProgressIndicator());
            case LoadingStates.success:
              return _buildBody(context);
            case LoadingStates.error:
              return Center(
                child: Text('Unexpected error'),
              );
            default:
              return Container();
          }
        },
      ),
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
                child: DashboardMenu(),
                elevation: 4,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                AppHeader(),
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
