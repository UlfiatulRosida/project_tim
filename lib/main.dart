import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Halaman Vira (Profile)
import 'package:project_tim/pages/profile_page.dart';

// Halaman Anggun
import 'pages/home_page.dart';
import 'pages/pengaduan_page.dart';

// Auth + Splash
import 'package:project_tim/pages/splash_page.dart';
import 'package:project_tim/pages/login_page.dart';
import 'package:project_tim/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool temaGelap = false;

  // Load tema simpanan
  Future<void> loadTema() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      temaGelap = prefs.getBool('temaGelap') ?? false;
    });
  }

  // Simpan tema
  Future<void> simpanPreferensiTema(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temaGelap', value);
  }

  @override
  void initState() {
    super.initState();
    loadTema();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surat Warga Malang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: temaGelap ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const MainScreen(),
        '/profile': (context) => HalamanProfile(
              onToggleTheme: (isDark) {
                simpanPreferensiTema(isDark);
                setState(() {
                  temaGelap = isDark;
                });
              },
            ),
      },
    );
  }
}

// -------------------------------------------
//              MAIN SCREEN
// -------------------------------------------

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    PengaduanPage(onBackToHome: () {}),
    const HalamanProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
