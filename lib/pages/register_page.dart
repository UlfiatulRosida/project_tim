import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
