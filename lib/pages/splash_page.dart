import 'package:flutter/material.dart';
import 'package:project_tim/pages/login_page.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPegeState();
}

class _SplashPageState extends State<SplashPage> {
  @override 
  void initState() {
    super.initState();
    _checkLoginStatus();
  }
}
// cek apakah user sudah login
Future<void> _checkLoginStatus() async {
  await Future.delayed(const Duration(seconds: 2)); // animasi spalsh

    final token = await AuthPrefs.getToken();
    
    if (!mounted) return;

    if (token !=null && token.isNotEmpty) {
      // jika sudah login, arahkan ke halaman utama
      Navigator.pushReplacementNamed(context, '/login');
    }else {
      // jika belum login, arahkan ke halaman login
      Navigator.pushReplacement(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children [
            image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
              ErrorBuilder: (context, eror, StackTrace) {
                return const Text('logo tidak ditemukan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              appName,
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
