import 'package:flutter/material.dart';
import 'package:project_tim/services/auth_prefs.dart';
import 'package:project_tim/services/api_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 2)); // animasi spalsh 2 detik
    await _checkLoginStatus();
  }

// cek apakah user sudah login
// jika ada token, arahkan ke halaman utama, jika tidak ada, arahkan ke halaman login
  Future<void> _checkLoginStatus() async {
    final token =
        await AuthPrefs.getToken(); // ambil token dari shared preferences

    if (!mounted) return; // pastikan widget masih terpasang

    if (token != null && token.isNotEmpty) {
      // cek token tidak null dan tidak kosong
      Navigator.pushReplacementNamed(
          context, '/login'); // user sudah login arahkan ke halaman utama
      return;
    }

    final profile = await ApiService.getProfile();

    if (profile['success'] == true) {
      await AuthPrefs.saveUser(profile['data']);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      await AuthPrefs.clearToken();

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // agar background mengikuti tema
      // Colors.white, // ganti dengan warna latar belakang yang diinginkan
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
              errorBuilder: (context, eror, stackTrace) {
                // tangani error jika asset tidak ditemukan
                return Text(
                  'logo tidak ditemukan',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    // Colors.white,
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Surat Warga Malang',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                // Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
