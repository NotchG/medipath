import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2)); // Optional: show splash for 2 seconds
    final token = await _storage.read(key: 'jwt_token');
    if (mounted) {
      bool isValid = false;
      if (token != null && token.isNotEmpty) {
        try {
          isValid = !JwtDecoder.isExpired(token);
        } catch (e) {
          // Invalid token format, clear it
          print('Invalid JWT token: $e');
          await _storage.delete(key: 'jwt_token');
          isValid = false;
        }
      }
      if (isValid) {
        context.go('/'); // User is logged in
      } else {
        context.go('/login'); // User is not logged in or token invalid
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/AuthPage/LogoMediPath.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to MediPath',
              style: TextStyle(
                color: Color(0xff44157D),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
