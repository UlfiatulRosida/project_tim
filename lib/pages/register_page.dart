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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

// Navigasi balik ke login
  void_goBack() {
    Navigator.pop(context);
  }

//
  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    final result = await AuthService.register(
      namalengkap: _namaController.text.trim(),
      username: _emailController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      notelepon: '',
      alamat: '',
    );

    setState(() => _isLoading = false);

    if (!mounted) return;

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Berhasil daftar')),
      );
      // setelah daftar kembali ke login
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Gagal mendaftar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Page',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
