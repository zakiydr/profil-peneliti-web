import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/dashboard_menu_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/publication_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/providers/features/scholars_provider.dart';
import 'package:profile_peneliti/services/notification_service.dart';
import 'package:profile_peneliti/services/workmanager_service.dart';
import 'package:profile_peneliti/views/auth/login_redirect.dart';
import 'package:profile_peneliti/views/auth/login.dart';
import 'package:profile_peneliti/views/main_dashboard/main_dashboard_init.dart';
import 'package:profile_peneliti/views/main_dashboard/main_dashboard_view.dart';
import 'package:profile_peneliti/views/pages/overview/overview_view.dart';
import 'package:profile_peneliti/views/pages/articles/articles_view.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';
// import 'package:shared_preferences_web/shared_preferences_web.dart';

import 'constants/app_routes.dart';
import 'theme/app_theme.dart';
import 'views/search/search_view.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().initNotification;

  // if (!kIsWeb) {
  //   await WorkmanagerService.initialize();
  // }

  runApp(const MyApp());
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
        ChangeNotifierProvider(create: (context) => GoogleAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '${_getInitialRoute()}',
        initialRoute: AppRoutes.splash,
        routes: {
          AppRoutes.splash: (context) => SplashScreen(),
          AppRoutes.login: (context) => const LoginScreen(),
          AppRoutes.loginRedirect: (context) => const LoginRedirect(),
          AppRoutes.search: (context) => const SearchView(),
          AppRoutes.dashboard: (context) => const MainDashboardInit(),
          AppRoutes.overview: (context) => OverviewView(),
          AppRoutes.articles: (context) => const ArticlesView(),
        },
        title: 'Profil Peneliti',
        theme: AppTheme.getTheme(context),
      ),
    );
  }
}
