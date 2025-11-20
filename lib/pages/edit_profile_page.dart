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
  late TextEditingController namaController;
  late TextEditingController teleponController;
  late TextEditingController alamatController;
  bool loading = false;

  File? fotoBaru;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(
      text: widget.dataAwal['nama_lengkap'] ?? "",
    );
    teleponController = TextEditingController(
      text: widget.dataAwal['no_telepon'] ?? "",
    );
    alamatController = TextEditingController(
      text: widget.dataAwal['alamat'] ?? "",
    );

    if (widget.dataAwal['foto'] != null && widget.dataAwal['foto'] is File) {
      fotoBaru = widget.dataAwal['foto'];
    }
  }

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
                title: const Text("Pilih foto dari galeri"),
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
            // fungsi untuk input nama
            TextField(
              controller: namaController,
              style: TextStyle(color: warnaTeks),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                labelText: "Nama Lengkap",
                labelStyle: TextStyle(color: warnaTeks),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            //input no telepon
            TextField(
              controller: teleponController,
              style: TextStyle(color: warnaTeks),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                labelText: "No. Telepon",
                labelStyle: TextStyle(color: warnaTeks),
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 15),

            //input alamat
            TextField(
              controller: alamatController,
              style: TextStyle(color: warnaTeks),
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                  ),
                ),
                labelText: "Alamat",
                labelStyle: TextStyle(color: warnaTeks),
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
