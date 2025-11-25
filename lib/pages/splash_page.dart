import 'package:flutter/material.dart';
import 'package:project_tim/services/auth_prefs.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

// cek apakah user sudah login
// jika ada token, arahkan ke halaman utama, jika tidak ada, arahkan ke halaman login
  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // animasi spalsh 2 detik

    final token =
        await AuthPrefs.getToken(); // ambil token dari shared preferences

    if (!mounted) return; // pastikan widget masih terpasang

    if (token != null && token.isNotEmpty) {
      // cek token tidak null dan tidak kosong
      Navigator.pushReplacementNamed(
          context, '/home'); // user sudah login arahkan ke halaman utama
    } else {
      Navigator.pushReplacementNamed(
          context, '/login'); // user belum login arahkan ke halaman login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // ganti dengan warna latar belakang yang diinginkan
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
                return const Text(
                  'logo tidak ditemukan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Surat Warga Malang',
              style: TextStyle(
                color: Colors.white,
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
