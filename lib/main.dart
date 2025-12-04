import 'package:flutter/material.dart';
vira-profile
import 'package:project_tim/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

anggun-pengaduan
import 'pages/home_page.dart';
import 'pages/pengaduan_page.dart';
import 'package:project_tim/pages/splash_page.dart';
import 'package:project_tim/pages/login_page.dart';
import 'package:project_tim/pages/register_page.dart';
main

main
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

vira-profile
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool temaGelap = false;

// Fungsi untuk load tema awal
  Future<void> loadTema() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      temaGelap = prefs.getBool('temaGelap') ?? false;
    });
  }

// Menyimpan tema ketika user mengganti tema
  Future<void> simpanPreferensiTema(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('temaGelap', value);
  }

  @override
  void initState() {
    super.initState();
    loadTema();
  }

  // This widget is the root of your application
  main
  @override
  Widget build(BuildContext context) {
anggun-pengaduan
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),

    return MaterialApp(
vira-profile
      debugShowCheckedModeBanner: false,
      title: 'Surat Warga',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.light), //terang
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue, brightness: Brightness.dark), //gelap
        useMaterial3: true,
      ),
      themeMode: temaGelap ? ThemeMode.dark : ThemeMode.light,
      home: HalamanProfile(
        onToggleTheme: (isDark) {
          simpanPreferensiTema(isDark);
          setState(() {
            temaGelap = isDark;
          });
        },
      ),

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
