//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';

class ApiService {
  static const String baseUrl =
      'https://suratwarga.malangkab.go.id/index.php/api';

  static Future<Map<String, String>> _headersWithAuth(
      {Map<String, String>? extra}) async {
    final token = await AuthPrefs.getToken();
    final header = <String, String>{
      'Content-type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    if (extra != null) header.addAll(extra);
    return header;
  }
}
