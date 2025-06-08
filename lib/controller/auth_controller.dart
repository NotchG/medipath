import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';

class AuthController {
  Future<LoginResponse?> login(LoginRequest request) async {
    final url = Uri.parse('https://medipathapi.notchgnas.com/api/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}