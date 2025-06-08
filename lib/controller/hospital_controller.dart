import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../model/hospital_model.dart';

class HospitalController {
  static Future<List<HospitalModel>> fetchHospitals() async {
    try {
      final response = await http.get(
        Uri.parse('https://dekontaminasi.com/api/id/covid19/hospitals'),
      );
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((json) => HospitalModel.fromJson(json)).toList();
      } else {
        final String jsonString = await rootBundle.loadString('assets/backup/hospitals.json');
        final List data = json.decode(jsonString);
        return data.map((json) => HospitalModel.fromJson(json)).toList();
      }
    } catch (e) {
      // Fallback: Load from asset
      final String jsonString = await rootBundle.loadString('assets/backup/hospitals.json');
      final List data = json.decode(jsonString);
      return data.map((json) => HospitalModel.fromJson(json)).toList();
    }
  }
}