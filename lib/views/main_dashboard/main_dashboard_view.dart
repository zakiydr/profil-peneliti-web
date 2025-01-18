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
              if (scholar.scholarDetail?.scholarId != null) {
                return _buildBody(context);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
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
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2025 Your Company Name',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.help_outline, color: Colors.grey[600]),
                onPressed: () {},
                tooltip: 'Help',
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.grey[600]),
                onPressed: () {},
                tooltip: 'Logout',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
