import 'package:flutter/material.dart';
import 'package:project_tim/pages/register_page.dart';
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
bool _obscureText = true;
bool _isLoadig = false;

// Animasi
late AnimationController _controller;
late Animation<double> _fadeAnimation;
late Animation<double> _slideAnimation;

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
    CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeIn,
    ),
      );

  _slideAnimation = Tween<Offset>(
    begin: const Offset(0, 0.2),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeOut,
  ));

  _controller.forward();
}

@override
void dispose() {
  _controller.dispose();
  _identityController.dispose();
  _passwordController.dispose();
  super.dispose();
}

Future<void> _login() async {
setState(() => _isLoadig = true);

try {
  final result = await AuthService().login(
  _identityController.text.trim(),
  _passwordController.text,
  );

  if (mounted) return;
  
  if (result['success']) {
   ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login berhasil!'), backgroundColor: Colors.green),
   );
    Navigator.pushReplacementNamed(context, '/register');
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(result['message'] ?? 'Login gagal'), backgroundColor: Colors.red),
    );
  }
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
  );
} finally {
  if (mounted) {
    setState(() => _isLoadig = false);
  }
}

void _validateAndSubmit() {
            if (_formKey.currentState!.validate()) {
              _login();
          }
          }
          

           
          void _navigateToRegister() {
      Navigator.of(context).push(_createRouteToRegister());
          }
    Route _createRouteToRegister() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const RegisterPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.ease));
          return SlideTransition(position: animation.drive(tween), child: child);
      },
      );
    }
  }
      }
@override
Widget build(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  return Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
          children: [
            Container(
              width: double.infinity,
              height: height * 0.3,)
              Decoration: const BoxDecoration(
                color: Color(0xFF1565c0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Padding(
                Padding: EdgeInsets.only(top: 80, left: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(height: height * 0.2),
            Text('Welcome to surat Warga',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            ),
           ],
                ),
              ),
            ),
            container(
              transform: Matrix4.translationValues(x, y, z),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              margin: const EdgeInsets.only(top: -40, left: 24, right: 24, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            child: Form(
        key: _formKey,
        child: Column(
          CrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _identityController,
              decoration: InputDecoration(
                labelText: 'Email or Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email or username';
                }
                return null;
              },
        ),
        const SizedBox(height: 25),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?'
            style: TextStyle(
              color: Color(0xFF1565c0),),),
      ),
    ),
    const SizedBox(height: 10),
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoadig ? null : _validateAndSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1565c0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoadig
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    ),
    const SizedBox(height: 20),
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Don\'t have an account? '),
          GestureDetector(
            onTap: _navigateToRegister,
            child: const Text(
              'Register',
              style: TextStyle(
                color: Color(0xFF1565c0),
                fontWeight: FontWeight.bold,
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
    }