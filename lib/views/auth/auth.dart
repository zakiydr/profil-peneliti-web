import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:jose/jose.dart';
import 'package:universal_platform/universal_platform.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final Dio _dio = Dio();
  late String _clientId;
  late String _redirectUri;

  final String _tokenEndpoint = 'https://oauth2.googleapis.com/token';
  final String _authEndpoint = 'https://accounts.google.com/o/oauth2/v2/auth';
  final String _userInfoEndpoint =
      'https://www.googleapis.com/oauth2/v3/userinfo';

  String? _email;
  String? _name;
  String? _pictureUrl;

  @override
  void initState() {
    super.initState();
    _configureClient();
  }

  void _configureClient() {
    if (kIsWeb) {
      _clientId =
          '64704630333-lvpqo21338ge1pnor3997s5s4im88igh.apps.googleusercontent.com';
      _redirectUri = 'localhost:8000/#/auth';
    } else if (UniversalPlatform.isAndroid) {
      _clientId =
          '64704630333-lvpqo21338ge1pnor3997s5s4im88igh.apps.googleusercontent.com';
      _redirectUri = 'com.example.gsprofile:/oauth2redirect';
    } else if (UniversalPlatform.isIOS) {
      _clientId =
          '64704630333-lvpqo21338ge1pnor3997s5s4im88igh.apps.googleusercontent.com';
      _redirectUri = 'com.example.gsprofile:/oauth2redirect';
    } else {
      throw UnsupportedError('Platform not supported');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final authUrl = Uri.parse(_authEndpoint).replace(
        queryParameters: {
          'response_type': 'code',
          'client_id': _clientId,
          'redirect_uri': _redirectUri,
          'scope': 'openid profile email',
          'state': 'security_token',
        },
      );

      final result = await FlutterWebAuth.authenticate(
        url: authUrl.toString(),
        callbackUrlScheme: kIsWeb
            ? Uri.parse(_redirectUri).scheme
            : _redirectUri.split(':')[0],
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) throw Exception('Authorization failed');

      final tokenResponse = await _dio.post(
        _tokenEndpoint,
        options: Options(
          headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        ),
        data: {
          'code': code,
          'client_id': _clientId,
          'redirect_uri': _redirectUri,
          'grant_type': 'authorization_code',
        },
      );

      final accessToken = tokenResponse.data['access_token'];
      final idToken = tokenResponse.data['id_token'];

      final user = await _getUserInfo(accessToken);
      final idTokenClaims = _parseIdToken(idToken);

      setState(() {
        _email = user['email'];
        _name = user['name'];
        _pictureUrl = user['picture'];
      });

      print('User Info: $user');
      print('ID Token Claims: $idTokenClaims');
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  Future<Map<String, dynamic>> _getUserInfo(String accessToken) async {
    final response = await _dio.get(
      _userInfoEndpoint,
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
    return response.data;
  }

  Map<String, dynamic> _parseIdToken(String idToken) {
    final jwt = JsonWebToken.unverified(idToken);
    return jwt.claims.toJson();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_pictureUrl != null)
            CircleAvatar(backgroundImage: NetworkImage(_pictureUrl!)),
          if (_name != null) Text('Name: $_name'),
          if (_email != null) Text('Email: $_email'),
          ElevatedButton(
            onPressed: _signInWithGoogle,
            child: const Text('Sign in with Google'),
          ),
        ],
      ),
    );
  }
}
