import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'providers/features/citation_provider.dart';
import 'providers/features/dashboard_menu_provider.dart';
import 'providers/features/notification_provider.dart';
import 'providers/features/publication_provider.dart';
import 'providers/features/scholar_detail_provider.dart';
import 'providers/features/scholars_provider.dart';
import 'theme/app_theme.dart';
import 'views/main_dashboard/main_dashboard_view.dart';
import 'views/pages/articles/articles_view.dart';
import 'views/pages/overview/overview_view.dart';
import 'views/search/search_view.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    Future<String?> _getInitialRoute() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        debugPrint('Initializing...');
        return prefs.containsKey('scholar_detail') ? '/dashboard' : '/';
      } catch (e) {
        debugPrint('Error accessing SharedPreferences: $e');
        return '/';
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ScholarsProvider()),
        ChangeNotifierProvider(create: (context) => ScholarDetailProvider()),
        ChangeNotifierProvider(create: (context) => DashboardMenuProvider()),
        ChangeNotifierProvider(create: (context) => CitationProvider()),
        ChangeNotifierProvider(create: (context) => PublicationProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
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
