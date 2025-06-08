import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String? _token;
  String? _userId;
  bool _isLoading = true;

  String? get token => _token;
  String? get userId => _userId;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadAuthData();
  }

  Future<void> _loadAuthData() async {
    _token = await _storage.read(key: 'jwt_token');
    _userId = await _storage.read(key: 'user_id');
    _isLoading = false;
    notifyListeners();
  }

  Future<void> setAuthData({required String token, required String userId}) async {
    _token = token;
    _userId = userId;
    await _storage.write(key: 'jwt_token', value: token);
    await _storage.write(key: 'user_id', value: userId);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'user_id');
    notifyListeners();
  }
}