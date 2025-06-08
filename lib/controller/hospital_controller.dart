import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/hospital_model.dart';

class HospitalController {
  static Future<List<HospitalModel>> fetchHospitals() async {
    final response = await http.get(
      Uri.parse('https://dekontaminasi.com/api/id/covid19/hospitals'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => HospitalModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hospitals');
    }
  }
}