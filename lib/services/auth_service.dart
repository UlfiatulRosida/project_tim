import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';

class AuthService {
  static const String baseUrl =
      'https://suratwarga.malangkab.go.id/index.php/api';

// Login
  static Future<Map<String, dynamic>> login(
      String identity, String password) async {
    try {
      final uri = Uri.parse('$baseUrl/login');
      final resp = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'identity': identity,
          'password': password,
        }),
      );

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      final token = body['token'];
// data user
      //final user = body['user'] ?? {};

// jika login sukses
      if (resp.statusCode == 200 && token != null) {
        await AuthPrefs.saveToken(token);
        return {
          'success': true,
          'message': body['message'] ?? 'login berhasil',
          'token': token,
          //'user': user,
        };
      }
      // login gagal
      return {
        'success': false,
        'message': body['message'] ?? 'login gagal',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// register
  static Future<Map<String, dynamic>> register({
    required String namaLengkap,
    required String username,
    required String email,
    required String password,
    required String noTelepon,
    required String alamat,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/register');
      final resp = await http.post(
        uri,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'nama_lengkap': namaLengkap,
          'username': username,
          'email': email,
          'password': password,
          'no_telepon': noTelepon,
          'alamat': alamat,
        }),
      );

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return {
          'success': true,
          'message': body['message'] ?? 'registrasi berhasil',
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'registrasi gagal',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// logout
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
          'Accept': 'application/json',
        },
      );

      await AuthPrefs.clearToken();

      return {
        'success': resp.statusCode == 200,
        'message': 'logout berhasil',
      };
    } catch (e) {
      await AuthPrefs.clearToken();
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
