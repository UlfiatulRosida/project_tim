import 'package:flutter/material.dart';
anggun-pengaduan
import 'pages/home_page.dart';
import 'pages/pengaduan_page.dart';
import 'package:project_tim/pages/splash_page.dart';
import 'package:project_tim/pages/login_page.dart';
import 'package:project_tim/pages/register_page.dart';

main
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
anggun-pengaduan
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),

    return MaterialApp(
      title: 'Surat Warga Malang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },
main
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      PengaduanPage(onBackToHome: () => _onItemTapped(0)),
    ];
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: _selectedIndex == 0
          ? BottomNavigationBar(
            backgroundColor: Colors.white,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: const Color(0xFF1565C0),
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline),
                  label: 'Pengaduan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
            )
            : null,
    );
  }
}
