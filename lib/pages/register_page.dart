import 'package:flutter/material.dart';
import 'package:project_tim/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  // input controller
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

// Navigasi balik ke login
  void _goBack() {
    Navigator.pop(context);
  }

  Future<void> _register() async {
    if (_isLoading) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final result = await AuthService.register(
      namalengkap: _namaController.text.trim(),
      username: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      notelepon: '',
      alamat: '',
    );

    if (!mounted) return;

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Register berhasil, silahkan login'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Register gagal'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 100, // Sesuaikan ukuran logo
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16), // Jarak antara logo dan teks
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hello',
                        style: TextStyle(
                          color: isDark ? Colors.grey[300] : Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Buat Akun Surat Warga',
                      style: TextStyle(
                        color: isDark ? Colors.grey[300] : Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -40, 0),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withAlpha(200),
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
                        'Daftar',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text('Nama Lengkap',
                        style: TextStyle(
                            fontSize: 14, color: theme.colorScheme.primary)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        hintText: 'Masukan Nama Lengkap',
                        hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withAlpha(180)),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama Wajib diisi'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text('Username',
                        style: TextStyle(
                            fontSize: 14, color: theme.colorScheme.primary)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Masukan Username',
                        hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withAlpha(180)),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Username Wajib disi'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Text('Email',
                        style: TextStyle(
                            fontSize: 14, color: theme.colorScheme.primary)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Masukan Email',
                        hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withAlpha(180)),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email wajib diisi';
                        }
                        if (!value.contains('@')) return 'Email tidak Valid';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Kata Sandi',
                        style: TextStyle(
                            fontSize: 14, color: theme.colorScheme.primary)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Masukan Kata Sandi',
                        hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withAlpha(180)),
                        filled: true,
                        fillColor: isDark
                            ? theme.colorScheme.surfaceContainerHighest
                            : Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password wajib diiisi';
                        }
                        if (value.length < 6) return 'Minimal 6 Karater';
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark
                              ? theme.colorScheme.onSurface.withAlpha(200)
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
                                'Daftar',
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
                            'Sudah Punya Akun ? ',
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    theme.colorScheme.onSurface.withAlpha(180)),
                          ),
                          GestureDetector(
                            onTap: _goBack,
                            child: Text(
                              'Login',
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
    );
  }
}
