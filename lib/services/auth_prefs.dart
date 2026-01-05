import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // simpan token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    print('TOKEN DISIMPAN: $token');
    await prefs.setString(_tokenKey, token);
  }

// ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

// simpan user (wajib object user saja, bukan response)
  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

  // ambil user
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_userKey);

    if (jsonStr == null) return null;
    //   try {
    //     final decoded = jsonDecode(jsonStr);
    //     if (decoded is Map<String, dynamic>) {
    //       return decoded;
    //     }
    //     return null;
    //   } catch (e) {
    //     return null;
    //   }
    // }
    try {
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Ambil nama user (helper)
  static Future<String?> getUserName() async {
    final user = await getUser();
    return user?['username'];
  }

  // cek login
  static Future<bool> isLoggedIn() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   return prefs.getString(_tokenKey) != null;
    // }
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // logout
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
