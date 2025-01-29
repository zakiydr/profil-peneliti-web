import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;
import 'package:dio/dio.dart';

class GoogleAuthService {
  static const _clientId =
      '64704630333-nvmlctudb7973rvfd0mtneqrgdtlvpok.apps.googleusercontent.com';
  static const _redirectUrl = 'com.example.gsprofile://oauthredirect';
  static const _discoveryUrl =
      'https://accounts.google.com/.well-known/openid-configuration';

  final _appAuth = FlutterAppAuth();
  final _secureStorage = storage.FlutterSecureStorage();
  final _dio = Dio();

  Future<UserModel?> signIn() async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _clientId,
          _redirectUrl,
          discoveryUrl: _discoveryUrl,
          scopes: ['openid', 'email', 'profile'],
          promptValues: ['login'],
          // allowInsecureConnections: true, // Only for testing with HTTP
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint:
                'https://accounts.google.com/o/oauth2/v2/auth',
            tokenEndpoint: 'https://oauth2.googleapis.com/token',
          ),
        ),

        // AuthorizationTokenRequest(
        //   _clientId,
        //   _redirectUrl,
        //   scopes: ['openid', 'email', 'profile'],
        //   promptValues: ['consent'],
        // ),
      );

      if (result != null) {
        await Future.wait([
          _secureStorage.write(key: 'access_token', value: result.accessToken),
          _secureStorage.write(
              key: 'refresh_token', value: result.refreshToken),
        ]);

        return await _fetchUserInfo(result.accessToken!);
      }
      return null;
    } catch (e, stackTrace) {
      debugPrint('Sign in error: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  Future _fetchUserInfo(String accessToken) async {
    try {
      final response = await _dio.get(
        'https://www.googleapis.com/oauth2/v3/userinfo',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      debugPrint('Fetch user info error: $e');
      return null;
    }
  }

  Future signOut() async {
    await _secureStorage.delete(key: 'access_token');
  }
}

class UserModel {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map json) {
    return UserModel(
      id: json['sub'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['picture'],
    );
  }
}
