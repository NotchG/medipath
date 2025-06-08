import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/register_model.dart';

class RegisterController {
  Future<RegisterResponse?> register(RegisterRequest request) async {
    final url = Uri.parse('https://medipathapi.notchgnas.com/api/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    print(jsonDecode(response.body));

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}