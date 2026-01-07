import 'dart:io';
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
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
    const primaryBlue = Color(0xFF1565c0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Surat Warga Malang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryBlue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryBlue, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: temaGelap ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => MainScreen(
              onToggleTheme: (isDark) {
                simpanPreferensiTema(isDark);
                setState(() {
                  temaGelap = isDark;
                });
              },
            ),
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
  final Function(bool)? onToggleTheme;
  const MainScreen({super.key, this.onToggleTheme});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  int _selectedIndexBeforeProfile = 0;

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      PengaduanPage(onBackToHome: () {
        setState(() {
          _selectedIndex = 0; // Kembali ke halaman Beranda
        });
      }),
      HalamanProfile(
        onToggleTheme: widget.onToggleTheme,
        onBack: () {
          setState(() {
            _selectedIndex =
                _selectedIndexBeforeProfile; // Kembali ke halaman Beranda
          });
        },
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      // Simpan halaman sebelumnya saat masuk ke Profile
      if (index == 2) {
        _selectedIndexBeforeProfile = _selectedIndex;
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Pengaduan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
