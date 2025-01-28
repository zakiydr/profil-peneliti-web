// Modify SignInScreen to StatefulWidget
import 'package:flutter/material.dart';
import 'package:profile_peneliti/services/google_auth_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _authService = GoogleAuthService();
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    
    try {
      final user = await _authService.signIn();
      if (user != null && mounted) { // Check if widget is still mounted
        // Navigate to home screen
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _isLoading ? null : _handleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}