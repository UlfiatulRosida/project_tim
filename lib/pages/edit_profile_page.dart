import 'package:flutter/material.dart';
// import 'edit_profile_page.dart';

class HalamanEditProfile extends StatefulWidget {
  final Map<String, dynamic> dataAwal;

  const HalamanEditProfile({super.key, required this.dataAwal});

  @override
  State<HalamanEditProfile> createState() => _HalamanEditProfileState();
}

class _HalamanEditProfileState extends State<HalamanEditProfile> {
  Widget build(BuildContext context) {
    // fungsi untuk mendapatkan warna teks berdasarkan tema
    final warnaTeks = Theme.of(context).colorScheme.onSurface;
    return Scaffold(
      backgroundColor: Theme.of(context)
          .colorScheme
          .surface, // untuk menyesuaikan warna latar belakang dengan tema
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .surface, // untuk menyesuaikan warna AppBar dengan tema
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Center(
        child: Text('Halaman Edit Profile'),
      ),
    );
  }
}
