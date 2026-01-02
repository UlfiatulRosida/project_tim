import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_tim/services/auth_prefs.dart';

class ApiService {
  static const String baseUrl =
      'https://suratwarga.malangkab.go.id/index.php/api';

  static Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    if (auth) {
      final token = await AuthPrefs.getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  static dynamic _safeDecode(String body) {
    try {
      return body.isNotEmpty ? jsonDecode(body) : {};
    } catch (e) {
      return body;
    }
  }

// get profile
  static Future<Map<String, dynamic>> getProfile() async {
    try {
      final uri = Uri.parse('$baseUrl/me');
      final resp = await http.get(
        uri,
        headers: await _headers(auth: true),
      );

      final body = _safeDecode(resp.body);

      if (resp.statusCode == 200 && body is Map<String, dynamic>) {
        return {
          'success': true,
          'data': body['data'] ?? body,
        };
      }

      return {
        'success': false,
        'message': body is Map ? body['message'] : 'Gagal mengambil profile',
        'status': resp.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

//get option/pd
  static Future<Map<String, dynamic>> getOptionspd() async {
    try {
      final uri = Uri.parse('$baseUrl/options/pd');

      final resp = await http.get(uri, headers: await _headers());

      final body = _safeDecode(resp.body);

      print('RESPONSE BODY: $body');

      if (resp.statusCode == 200) {
        return {
          'success': true,
          'data': body['data'] ?? body,
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'Gagal mengambil opsi pd',
        'raw': body,
        //'status': resp.statusCode,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // GET pengaduan list (authenticated)
  static Future<Map<String, dynamic>> getPengaduan() async {
    // {String status = 'Public'}) async {
    try {
      //final token = await AuthPrefs.getToken();
      final uri = Uri.parse('$baseUrl/pengaduan');
      final resp = await http.get(
        uri,
        headers: await _headers(auth: true),
      );
      //{
      //'Accept': 'application/json',
      //if (token != null) 'Authorization': 'Bearer $token',
      //},
      //final body = _safeDecode(resp.body);
      final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : {};
      print('RESP PENGADUAN RAW: $body');
      if (resp.statusCode == 200) {
        return {
          'success': true,
          'data': body['data'],
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'Gagal mengambil pengaduan',
        'raw': body,
        //'status': resp.statusCode,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // POST pengaduan create (multipart if you need file; here simple form)
  static Future<Map<String, dynamic>> createPengaduan({
    // Map<String, String?> payload, {
    // Map<String, String> data) async {
    required String judul,
    required String isiSurat,
    required int idPd,
    String statusPrivasi = 'Public',
    // String statusPrivasi = 'Public',
  }) async {
    try {
      //final token = await AuthPrefs.getToken();
      final uri = Uri.parse('$baseUrl/pengaduan/create');
      final resp = await http.post(
        uri,
        // headers: await _headers(auth: true),
        // body: jsonEncode(data),
        // headers: await _headers(auth: true),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${await AuthPrefs.getToken()}',
        },
        //{
        //'Accept': 'application/json',
        //'Content-Type': 'application/json',
        //if (token != null) 'Authorization': 'Bearer $token',
        //},

        body: jsonEncode({
          'judul': judul,
          'isi_surat': isiSurat,
          'id_pd': idPd,
          'status_privasi': statusPrivasi,
        }),
      );

      //final body = _safeDecode(resp.body);
      final body = resp.body.isNotEmpty ? jsonDecode(resp.body) : {};
      print('RESPONSE CREATE PENGADUAN: $body');
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        return {
          'success': true,
          'message': body['message'] ?? 'Pengaduan berhasil dibuat',
          'data': body,
        };
      }
      return {
        'success': false,
        'message': body['message'] ?? 'Gagal membuat pengaduan',
        'raw': body,
        // 'status': resp.statusCode,
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // update profile
  static Future<Map<String, dynamic>> updateProfile(
      Map<String, String> data) async {
    try {
      final uri = Uri.parse('$baseUrl/me/update');

      final resp = await http.post(
        uri,
        headers: {
          ...(await _headers(auth: true)),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final body = _safeDecode(resp.body);

      if (resp.statusCode == 200 && body is Map<String, dynamic>) {
        return {
          'success': true,
          'data': body['data'] ?? body,
        };
      }
      return {
        'success': false,
        'message': body is Map ? body['message'] : 'Gagal memperbarui profile',
        //'raw': body,
        'status': resp.statusCode,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // logout
  static Future<Map<String, dynamic>> logout() async {
    try {
      final uri = Uri.parse('$baseUrl/logout');
      final resp = await http.post(uri, headers: await _headers(auth: true));

      if (resp.statusCode == 200) {
        await AuthPrefs.clearToken();
        return {'success': true};
      }
      return {
        'success': false,
        'status': resp.statusCode,
        'raw': _safeDecode(resp.body),
      };
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
