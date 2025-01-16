import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/providers/features/scholars_provider.dart';
import 'package:profile_peneliti/services/notification_service.dart';
import 'package:profile_peneliti/views/main_dashboard/main_dashboard_view.dart';
import 'package:profile_peneliti/views/pages/overview/overview_view.dart';
import 'package:profile_peneliti/views/pages/articles/articles_view.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'theme/app_theme.dart';
import 'views/search/search_view.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initNotification;
  // String? initialRoute;
  // debugPrint('Initializing...');
  // try {
  //   final prefs = await SharedPreferences.getInstance();
  //   initialRoute = prefs.containsKey('scholar_detail') ? '/dashboard' : '/';
  // } catch (e) {
  //   debugPrint('Error accessing SharedPreferences: $e');
  //   initialRoute = '/';
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScholarsProvider()),
        ChangeNotifierProvider(create: (context) => ScholarDetailProvider()),
        ChangeNotifierProvider(create: (context) => DashboardMenuProvider()),
        ChangeNotifierProvider(create: (context) => CitationProvider()),
        ChangeNotifierProvider(create: (context) => PublicationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '${_getInitialRoute()}',
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/search': (context) => SearchView(),
          '/dashboard': (context) => MainDashboardView(),
          '/overview': (context) => OverviewView(),
          '/articles': (context) => const ArticlesView(),
        },
        title: 'Profil Peneliti',
        theme: AppTheme.getTheme(context),
      ),
    );
  }
}
