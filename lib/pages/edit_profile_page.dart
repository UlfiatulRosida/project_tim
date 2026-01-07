import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_tim/services/api_service.dart';

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

  //variabel eror
  String? erorNama;
  String? erorTelepon;
  String? erorAlamat;

  //foto baru
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

  //nyambung api
  Future<void> simpanData() async {
    setState(() {
      erorNama = namaController.text.isEmpty ? "Nama Tidak Boleh Ksong" : null;
      erorTelepon = teleponController.text.isEmpty
          ? "Nomor Telepon Tidak Boleh Kosong"
          : null;
      erorAlamat =
          alamatController.text.isEmpty ? "Alamat Tidak Boleh Kosong" : null;
    });
    if (erorNama != null || erorAlamat != null || erorTelepon != null) return;

    setState(() => loading = true);

    final payload = {
      'nama_lengkap': namaController.text,
      'no_telepon': teleponController.text,
      'alamat': alamatController.text,
    };
    final result = await ApiService.updateProfile(payload);

    if (result['success'] == true) {
      Navigator.pop(context, {
        "nama_lengkap": namaController.text,
        "no_telepon": teleponController.text,
        "alamat": alamatController.text,
        "foto": fotoBaru,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Gagal memperbarui profile'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  //konfirmasi hapus foto
  void _konfirmasiHapusFoto() async {
    final konfirmasi = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: const Text("Hapus Foto Profile"),
            content:
                const Text("Apakah kamu yakin ingin menghapus foto profile??"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Batal")),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Hapus", style: TextStyle(color: Colors.red)),
              )
            ],
          );
        });
    if (konfirmasi == true) {
      setState(() {
        fotoBaru = null;
      });
    }
  }

// pilihan foto
  void _tampilPilihanFoto() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              // hapus foto
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Hapus Foto Profile"),
                onTap: () {
                  Navigator.pop(context);
                  _konfirmasiHapusFoto();
                },
              )
            ],
          ),
        );
      },
    );
  }

  //Ambil foto
  Future<void> _ambilFoto(ImageSource source) async {
    final hasil = await _picker.pickImage(source: source, imageQuality: 80);
    if (hasil != null) {
      setState(() {
        fotoBaru = File(hasil.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final warnaTeks = Theme.of(context).colorScheme.onSurface;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: warnaTeks),
          onPressed: () => Navigator.pop(context, false),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: warnaTeks,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      // body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage:
                      fotoBaru != null ? FileImage(fotoBaru!) : null,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.grey
                          : Colors.black,
                  child: fotoBaru == null
                      ? Icon(
                          Icons.person,
                          size: 55,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        )
                      : null,
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
                errorText: erorNama,
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
                errorText: erorTelepon,
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
                errorText: erorAlamat,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 30),

            // tombol simpan
            if (loading)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: simpanData,
                    icon: const Icon(Icons.save),
                    label: const Text("Simpan"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12)),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context, false),
                    icon: Icon(Icons.close, color: warnaTeks),
                    label: Text("Batal", style: TextStyle(color: warnaTeks)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
