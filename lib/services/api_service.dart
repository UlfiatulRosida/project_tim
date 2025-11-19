import 'dart:convert';
import 'package:http/http.dart' as http;
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

  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final uri = Uri.parse('$baseUrl/me');
      final headers = await _headersWithAuth();
      final resp = await http.get(uri, headers: headers);
      final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : {};

      if (resp.statusCode == 200) {
        return {'success': true, 'data': body};
      }

      return {
        'success': false,
        'message': body['message'] ?? 'Gagal mengambil profile',
        'raw': body,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: ${e.toString()}'};
    }
  }
}
