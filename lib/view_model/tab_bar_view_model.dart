import 'package:flutter/material.dart';

class TabBarViewModel extends ChangeNotifier {
  TabController? _tabController;
  bool _isInitialized = false;

  final List<Tab> tabs = const [
    Tab(text: 'ARTICLES'),
    Tab(text: 'CITED BY'),
    Tab(text: 'CO-AUTHORS'),
  ];

  bool get isInitialized => _isInitialized;

  TabController get profileTabController {
    if (_tabController == null) {
      throw StateError('TabController not initialized.');
    }
    return _tabController!;
  }

  void initialize(TickerProvider vsync) {
    if (_isInitialized) return;

    _tabController = TabController(
      length: tabs.length,
      vsync: vsync,
    );

    _tabController!.addListener(_handleTabChange);
    _isInitialized = true;
    notifyListeners();
  }

  void _handleTabChange() {
    notifyListeners();
  }

  int get currentIndex => _tabController?.index ?? 0;

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }
}


// class TabBarViewModel extends ChangeNotifier {
//   late TabController _tabController;

//   TabController get profileTabController => _tabController;

//   // Initialzation
//   bool get isInitialized => _tabController != null;

//   final List<Widget> _profileTabs = [
//     Tab(
//       text: 'ARTICLES',
//     ),
//     Tab(
//       text: 'CITED BY',
//     ),
//     Tab(
//       text: 'CO-AUTHORS',
//     ),
//   ];

//   List<Widget> get tabs => _profileTabs;

//   void setTabController(TickerProvider vsync) {
//     _tabController = TabController(length: _profileTabs.length, vsync: vsync);
//     notifyListeners();
//   }

//   // Change Tab
//   int get currentIndex => _tabController.index;

//   void changeTab(int index) {
//     _tabController.animateTo(index);
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
// }
