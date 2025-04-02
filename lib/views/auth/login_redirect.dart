import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:profile_peneliti/constants/app_images.dart';
import 'package:profile_peneliti/extension/string_extension.dart';
import 'package:profile_peneliti/providers/features/citation_provider.dart';
import 'package:profile_peneliti/providers/features/google_auth_provider.dart';
import 'package:profile_peneliti/providers/features/scholar_detail_provider.dart';
import 'package:profile_peneliti/services/proxy_service.dart';
import 'package:profile_peneliti/theme/app_colors.dart';
import 'package:provider/provider.dart';

import '../../constants/app_routes.dart';

class LoginRedirect extends StatefulWidget {
  const LoginRedirect({super.key});

  @override
  State<LoginRedirect> createState() => _LoginRedirectState();
}

class _LoginRedirectState extends State<LoginRedirect> {
  bool _isLoading = true;
  String _errorMessage = '';
  final ProxyService _proxyService = ProxyService();
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    try {
      await _proxyService.setProxy();
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to set proxy: ${e.toString()}';
        });
      }
      return;
    }

    if (!mounted) return;
    
    final scholarly = Provider.of<ScholarDetailProvider>(context, listen: false);
    final citation = Provider.of<CitationProvider>(context, listen: false);
    final auth = Provider.of<GoogleAuthProvider>(context, listen: false);

    try {
      await auth.login();
      
      final name = scholarly.dummyName;
      // final name = '${auth.user?.displayName} ${auth.user?.email.splitDomain()}';
      
      await scholarly.fetchScholarByName(name);
      
      if (scholarly.scholarDetail != null) {
        scholarly.saveData();
        scholarly.saveId(scholarly.scholarDetail!.scholarId.toString());
        citation.saveCitation(scholarly.scholarDetail!.citedby);
        
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.dashboard);
        }
      } else {
        throw Exception('Scholar details not found');
      }
    } catch (e) {
      if (mounted) {
        try {
          await auth.logout();
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        } catch (logoutError) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Error: ${e.toString()}';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AppImages.appIcon),
              width: 100,
            ),
            const SizedBox(height: 20),
            if (_isLoading) ...[
              LoadingAnimationWidget.waveDots(color: AppColors.blue, size: 50),
              const SizedBox(height: 16),
              const Text('Signing in...'),
            ] else ...[
              Text(
                _errorMessage,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = '';
                  });
                  _initializeData();
                },
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}