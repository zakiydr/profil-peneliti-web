import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_peneliti/views/main_dashboard.dart';
import 'package:profile_peneliti/views/main_view.dart';
import 'package:profile_peneliti/view_model/tab_bar_view_model.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Preload the Inter font to avoid FOUC (Flash of Unstyled Content)
  await GoogleFonts.pendingFonts([
    GoogleFonts.inter(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TabBarViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: const [
              Breakpoint(start: 0, end: 800, name: MOBILE),
              Breakpoint(start: 801, end: 1000, name: TABLET),
              Breakpoint(start: 1001, end: double.infinity, name: DESKTOP),
            ],
          );
        },
        title: 'Profil Peneliti',
        theme: ThemeData(
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: MainDashboard(),
      ),
    );
  }
}
