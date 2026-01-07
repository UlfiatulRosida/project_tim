import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';
import 'package:project_tim/services/api_service.dart';

class AuthService {
  static const String baseUrl =
      'https://suratwarga.malangkab.go.id/index.php/api';

// Login
  static Future<Map<String, dynamic>> login(
    String identity,
    String password,
  ) async {
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

      print('TOKEN DARI API: ${body['token']}');

// ambil token
      final token = body['token'];

      if (resp.statusCode == 200 && token != null) {
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

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return {
          'success': true,
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
      print('REGISTER EXCEPTION: $e');
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// forgot password
  static Future<Map<String, dynamic>> forgotPassword(String identity) async {
    try {
      final uri = Uri.parse('$baseUrl/password/forgot');

      final resp = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'identity': identity,
        }),
      );

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      if (resp.statusCode == 200) {
        return {
          'success': true,
          'message': body['message'] ?? 'Link reset password dikirim ke email',
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'Gagal mengirim reset password',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// reset password
  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String token,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/password/reset');

      final resp = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'token': token,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      if (resp.statusCode == 200) {
        return {
          'success': true,
          'message': body['message'] ?? 'Password berhasil direset',
        };
      }

      return {
        'success': false,
        'message': body['message'] ?? 'Reset password gagal',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// CHECK TOKEN VALID (used in Splash)
  static Future<bool> checkTokenValid() async {
    final token = await AuthPrefs.getToken();

    print('TOKEN DIPAKAI: $token');

    if (token == null) return false;

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
        'message': 'Error: $e',
      };
    }
  }
}
