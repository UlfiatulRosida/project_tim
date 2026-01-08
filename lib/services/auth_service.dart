import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';
import 'package:project_tim/services/api_service.dart';

class AuthService {
// Login
  static Future<Map<String, dynamic>> login(
    String identity,
    String password,
  ) async {
    try {
      final uri = Uri.parse('${ApiService.baseUrl}/api/login');

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

      print('TOKEN DARI API: ${body['token']}');

      // LOGIN SALAH
      if (resp.statusCode == 401 || resp.statusCode == 422) {
        return {
          'success': false,
          'message': 'Username atau password anda salah',
          'status': resp.statusCode,
        };
      }

// ambil token
      if (resp.statusCode == 200 && body['token'] != null) {
        final token = body['token'];
        // simpan token
        await AuthPrefs.saveToken(token.toString());

// ambil profile
        final profileResult = await ApiService.getProfile();
        if (profileResult['success'] == true && profileResult['data'] is Map) {
          await AuthPrefs.saveUser(
            Map<String, dynamic>.from(profileResult['data']['user']),
          );
        }
        return {
          'success': true,
          'message': body['message'] ?? 'login berhasil',
          'token': token,
        };
      }
      // login gagal
      return {
        'success': false,
        'message': body['message'] ?? 'login gagal',
        'status': resp.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan koneksi',
      };
    }
  }

// register
  static Future<Map<String, dynamic>> register({
    required String namalengkap,
    required String username,
    required String email,
    required String password,
    required String notelepon,
    required String alamat,
  }) async {
    try {
      final uri = Uri.parse('${ApiService.baseUrl}/api/register');

      final resp = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'nama_lengkap': namalengkap,
          'username': username,
          'email': email,
          'password': password,
          'no_telepon': notelepon,
          'alamat': alamat,
        }),
      );

      print('REGISTER STATUS CODE: ${resp.statusCode}');
      print('REGISTER RAW BODY: ${resp.body}');

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      print('REGISTER DECODED BODY: $body');

      if (resp.statusCode >= 200 && resp.statusCode < 300) {
        return {
          'success': true,
          'message': body['message'] ?? 'Registrasi berhasil',
          'data': body,
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'Registrasi gagal',
        'status': resp.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan koneksi',
      };
    }
  }

// forgot password
  static Future<Map<String, dynamic>> forgotPassword(String identity) {
    return ApiService.forgotPassword(email: identity);
  }

// reset password
  static Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
  }) {
    return ApiService.resetPassword(
      token: token,
      password: password,
    );
  }

// CHECK TOKEN
  static Future<bool> checkTokenValid() async {
    final token = await AuthPrefs.getToken();

    print('TOKEN DIPAKAI: $token');

    if (token == null || token.isEmpty) return false;

    final profile = await ApiService.getProfile();
    if (profile['success'] == true) return true;

    await AuthPrefs.clearToken();
    return false;
  }

  // LOGOUT server + clear local
  static Future<Map<String, dynamic>> logout() async {
    try {
      final result = await ApiService.logout();
      await AuthPrefs.clearToken();
      return result;
    } catch (e) {
      await AuthPrefs.clearToken();
      return {
        'success': false,
        'message': 'Terjadi Kesalahan',
      };
    }
  }
}
