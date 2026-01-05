// vira-profile

import 'package:flutter/material.dart';
import 'package:project_tim/pages/register_page.dart';
import 'package:project_tim/services/api_service.dart';
import 'package:project_tim/services/auth_prefs.dart';
import 'package:project_tim/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

// Animasi
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

// login
  Future<void> _login() async {
    if (_isLoading) return; // cegah double tap

    if (!_formKey.currentState!.validate()) {
      return; // validasi form agar backend tdk dibebani request tidak valid
    }

    setState(() => _isLoading = true); // tampilkan loading

    try {
      final identity = _identityController.text.trim();
      final password = _passwordController.text.trim();

      final result = await AuthService.login(identity, password);

      if (!mounted) return;

      if (result['success'] == true) {
        // save profile already attempted inside AuthService, but ensure saved:
        final profileRes = await ApiService.getProfile();
        if (profileRes['success'] == true && profileRes['data'] is Map) {
          await AuthPrefs.saveUser(profileRes['data']['user']);
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login berhasil'),
            backgroundColor: Colors.green,
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        final message = result['message']?.toString() ?? 'Login gagal';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateToRegister() {
    Navigator.of(context).push(_createRouteToRegister());
  }

  Route _createRouteToRegister() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    //warna biru utama
    const primaryBlue = Color(0xFF1565C0);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      // theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor:
            isDark ? theme.colorScheme.surfaceContainerHighest : primaryBlue,
        foregroundColor: isDark ? theme.colorScheme.onSurface : Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // header
                Container(
                  width: double.infinity,
                  height: height * 0.35,
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : primaryBlue,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80, left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(
                            color: isDark ? Colors.grey[300] : Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Selamat Datang Di Surat Warga',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withAlpha(204),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Email / Username',
                          style: TextStyle(
                              fontSize: 14, color: theme.colorScheme.primary),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _identityController,
                          decoration: InputDecoration(
                            hintText: 'Masukan email / username',
                            hintStyle: TextStyle(
                                color:
                                    theme.colorScheme.onSurface.withAlpha(204)),
                            filled: true,
                            fillColor: isDark
                                ? theme.colorScheme.surfaceContainerHighest
                                : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email atau username tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'kata sandi',
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(color: theme.colorScheme.onSurface),
                          decoration: InputDecoration(
                            hintText: 'Masukan Kata Sandi',
                            hintStyle: TextStyle(
                                color:
                                    theme.colorScheme.onSurface.withAlpha(204)),
                            filled: true,
                            fillColor: isDark
                                ? theme.colorScheme.surfaceContainerHighest
                                : Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kata sandi tidak boleh kosong';
                            } else if (value.length < 6) {
                              return 'Kata sandi minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Lupa Kata Sandi',
                              style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _validateAndLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark
                                  ? theme.colorScheme.onSurface.withAlpha(204)
                                  : primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Masuk',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onPrimary),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum memiliki akun?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              GestureDetector(
                                onTap: _navigateToRegister,
                                child: Text(
                                  'Daftar',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// main
