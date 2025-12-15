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
// ambil token
      final token = body['token'];

      if (resp.statusCode == 200 && token != null) {
        // simpan token
        await AuthPrefs.saveToken(token.toString());

// ambil profile
        final profileResult = await ApiService.getProfile();
        if (profileResult['success'] == true && profileResult['data'] is Map) {
          await AuthPrefs.saveUser(
            Map<String, dynamic>.from(profileResult['data']),
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

      // dynamic body;
      // try {
      //   body = resp.body.isNotEmpty ? jsonDecode(resp.body) : {};
      // } catch (e) {
      //   return {
      //     'success': false,
      //     'message': 'Response bukan JSON',
      //     'raw': resp.body
      //   };
      // }

      final body =
          resp.body.isNotEmpty ? jsonDecode(resp.body) : <String, dynamic>{};

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        // tidak simpan token otomatis setelah registrasi
        // if (body is Map && body['token'] != null) {
        //   await AuthPrefs.saveToken(body['token'].toString());
        // }
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
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

// CHECK TOKEN VALID (used in Splash)
  static Future<bool> checkTokenValid() async {
    final token = await AuthPrefs.getToken();
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

// // logout
//   static Future<void> logoutlocal() async {
//     await AuthPrefs.clearToken();
//   }

//   static Future<Map<String, dynamic>> logoutserver() async {
//     try {
//       final token = await AuthPrefs.getToken();

//       if (token == null) {
//         await AuthPrefs.clearToken();
//         return {
//           'success': true,
//           'message': 'sudah logout',
//         };
//       }
//       final uri = Uri.parse('$baseUrl/logout');
//       final resp = await http.post(
//         uri,
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       );

//       await AuthPrefs.clearToken();

//       return {
//         'success': resp.statusCode == 200,
//         'message': 'logout berhasil',
//       };
//     } catch (e) {
//       await AuthPrefs.clearToken();
//       return {
//         'success': false,
//         'message': 'Error: $e',
//       };
//     }
//   }
// }
