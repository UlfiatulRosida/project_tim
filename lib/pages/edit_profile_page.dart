import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'edit_profile_page.dart';

class HalamanEditProfile extends StatefulWidget {
  final Map<String, dynamic> dataAwal;

  const HalamanEditProfile({super.key, required this.dataAwal});

  @override
  State<HalamanEditProfile> createState() => _HalamanEditProfileState();
}

class _HalamanEditProfileState extends State<HalamanEditProfile> {
  File? fotoBaru;
  final ImagePicker _picker = ImagePicker();

// pilihan foot
  void _tampilPilihanFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Theme.of(context).colorScheme.surface, // sesuaikan dengan tema
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt,
                    color: Theme.of(context).colorScheme.primary),
                title: const Text("Ambil foto dari camera"),
                onTap: () {
                  Navigator.pop(context);
                  _ambilFoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text("Pilih dari galeri"),
                onTap: () {
                  Navigator.pop(context);
                  _ambilFoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //Ambil foto
  Future<void> _ambilFoto(ImageSource source) async {
    final hasil = await _picker.pickImage(source: source);
    if (hasil != null) {
      setState(() {
        fotoBaru = File(hasil.path);
      });
    }
  }

  @override
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: fotoBaru != null
                      ? FileImage(fotoBaru!)
                      : const NetworkImage("https://i.pravatar.cc/150?img=5")
                          as ImageProvider,
                ),
                InkWell(
                  onTap: _tampilPilihanFoto,
                  child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      )),
                )
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
