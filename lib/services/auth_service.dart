import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';

class AuthService {
  static const String baseUrl =
      'https://suratwarga.malangkab.go.id/index.php/api';

  static Future<Map<String, dynamic>> login(
      String identity, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/login');
      final resp = await http.post(
        uri,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'identity': identity, 'password': password}),
      );

      final code = resp.statusCode;
      final body = resp.body.isNotEmpty
          ? jsonDecode(resp.body) as Map
          : <String, dynamic>{};

      if (code == 200 && (body['token'] != null || body['success'] == true)) {
        final token = body['token'] ??
            (body['data'] != null && body['data']['token'] != null
                ? body['data']['token']
                : null);

        final userData =
            body['user'] ?? body['data']?['user'] ?? body['data'] ?? {};

        if (token != null) {
          await AuthPrefs.saveSession(token, userData);
        }

        return {
          'success': true,
          'message': body['message'] ?? 'login berhasil',
          'token': token,
          'user': userData,
          'raw': body
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'login gagal',
        'raw': body,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> register({
    required String namalengkap,
    required String username,
    required String email,
    required String password,
    required String notelepon,
    required String alamat,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/register');
      final resp = await http.post(
        uri,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'namalengkap': namalengkap,
          'username': username,
          'email': email,
          'password': password,
          'notelepon': notelepon,
          'alamat': alamat,
        }),
      );

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return {
          'success': body['success'] ?? true,
          'message': body['message'] ?? 'registrasi berhasil',
          'raw': body,
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'registrasi gagal',
        'raw': body,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }

  static Future<void> logoutlocal() async {
    await AuthPrefs.clearToken();
  }

  static Future<Map<String, dynamic>> logoutserver() async {
    try {
      final token = await AuthPrefs.getToken();

      if (token == null) {
        await AuthPrefs.clearToken();
        return {
          'success': true,
          'message': 'sudah logout',
        };
      }
      final uri = Uri.parse('$baseUrl/logout');
      final resp = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json',
        },
      );

      await AuthPrefs.clearToken();

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return {
          'success': true,
          'message': body['message'] ?? 'logout berhasil',
        };
      }

      return {
        'success': false,
        'message': body['message'] ?? 'logout gagal',
        'raw': body,
      };
    } catch (e) {
      await AuthPrefs.clearToken();
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
