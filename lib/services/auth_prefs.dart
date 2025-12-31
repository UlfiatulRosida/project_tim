import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // static const String _emailKey = 'auth_email';
  // static const String _passwordKey = 'auth_password';

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

// simpan user dari me
  static Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user));
  }

// simpan email
//   static Future<void> saveEmail(String email) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_emailKey, email);
//   }

// // simpan password
//   static Future<void> savePassword(String password) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_passwordKey, password);
//   }

  // ambil user
  static Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_userKey);

    if (jsonStr == null) return null;

    try {
      final decoded = jsonDecode(jsonStr);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

// ambil email
  // static Future<String?> getEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_emailKey);
  // }

  // // ambil password
  // static Future<String?> getPassword() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_passwordKey);
  // }

  // cek login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  // logout
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);

    // await prefs.remove(_emailKey);
    // await prefs.remove(_passwordKey);
  }
}
