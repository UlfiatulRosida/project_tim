import 'dart:math';

import 'package:flutter/material.dart';

class HalamanProfile extends StatefulWidget {
  final Function(bool)? onToggleTheme;

  const HalamanProfile({super.key, this.onToggleTheme});

  @override
  State<HalamanProfile> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfile> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final warnaUtama = isDark
        ? Color.fromARGB(255, 40, 40, 40) // Warna biru untuk mode gelap
        : Color.fromARGB(211, 13, 58, 181); // Warna biru untuk mode terang

    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaUtama,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profile Saya', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () {
              widget.onToggleTheme?.call(!isDark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: warnaUtama,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
