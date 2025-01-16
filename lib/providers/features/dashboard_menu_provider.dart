import 'package:flutter/material.dart';
import 'package:profile_peneliti/views/pages/overview/overview_view.dart';
import 'package:profile_peneliti/views/pages/articles/articles_view.dart';
import 'package:profile_peneliti/views/search/search_view.dart';
import 'package:profile_peneliti/views/splash/splash_screen.dart';

import '../app_provider.dart';

class DashboardMenuProvider extends AppProvider {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  final _pages = [
    OverviewView(),
    ArticlesView(),
    SearchView(),
  ];

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  int get selectedIndex => _selectedIndex;
  List get pages => _pages;

  void controlMenu(BuildContext context) {
    final scaffoldState = Scaffold.of(context);
    if (!scaffoldState.isDrawerOpen) {
      scaffoldState.openDrawer();
    }
  }

  void setSelectedIndex(BuildContext context, int index) {
    _selectedIndex = index;
    notifyListeners();
    final scaffoldState = Scaffold.of(context);
    if (scaffoldState.isDrawerOpen) {
      scaffoldState.closeDrawer();
    }
  }

  void goToOverview(BuildContext context) => setSelectedIndex(context, 0);
  void goToArticles(BuildContext context) => setSelectedIndex(context, 1);
  void goToCitations(BuildContext context) => setSelectedIndex(context, 2);
}
