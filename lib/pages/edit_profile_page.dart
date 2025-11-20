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
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Center(
        child: Text('Halaman Edit Profile'),
      ),
    );
  }
}
