import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medipath/model/update_profile_req_model.dart';
import 'package:medipath/model/user_profile_model.dart';
import 'package:medipath/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ProfileController {
  Future<UserProfile?> fetchProfile(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    final userId = authProvider.userId;

    if (token == null || userId == null) return null;

    final url = Uri.parse('https://medipathapi.notchgnas.com/api/profile/$userId');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data['user']);
    } else {
      return null;
    }
  }

  Future<bool> updateProfile(BuildContext context, UpdateProfileRequest request) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;
    final userId = authProvider.userId;

    if (token == null || userId == null) return false;

    final url = Uri.parse('http://192.168.50.74:8080/api/profile/$userId');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );

    return response.statusCode == 200;
  }
}