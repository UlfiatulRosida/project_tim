// import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanProfile extends StatefulWidget {
  final Function(bool)? onToggleTheme;

  const HalamanProfile({super.key, this.onToggleTheme});

  @override
  State<HalamanProfile> createState() => _HalamanProfileState();
}

class _HalamanProfileState extends State<HalamanProfile> {
  // 🔹 PERUBAHAN: HAPUS temaGelap lokal
  // bool temaGelap = false;

  Map<String, dynamic> dataProfile = {
    "nama_lengkap": "Nutria Ayu",
    "username": "nutria123",
    "email": "nutria@gmail.com",
    "no_telepon": "+62 831-8140-000",
    "alamat": "Jl. Melati No. 45, Malang",
    "pd_nama": "1",
    "status": "Aktif",
    "created_at": "12 Januari 2024, 12:23:45",
    "role": "warga",
    "foto": null,
  };

  File? fotoProfile;

// Menyimpan path foto profil ke SharedPreferences
  Future<void> simpanFotoProfile(String pathFoto) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('path_foto_profil', pathFoto);
  }

  // Mengambil path foto profil dari SharedPreferences saat inisialisasi
  Future<void> ambilFotoProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final pathFoto = prefs.getString('fotoProfilePath');
    if (pathFoto != null) {
      setState(() {
        fotoProfile = File(pathFoto);
        dataProfile["foto"] = fotoProfile;
      });
    }
  }

  // Inisialisasi state
  @override
  void initState() {
    super.initState();
    ambilFotoProfile();
  }

  // Navigasi ke halaman edit profile dan menunggu hasilnya
  void pindahKeEdit() async {
    final hasil = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HalamanEditProfile(dataAwal: dataProfile),
      ),
    );
    if (hasil != null && hasil is Map<String, dynamic>) {
      setState(() {
        dataProfile = {...dataProfile, ...hasil};
      });
      if (hasil["foto"] != null && hasil["foto"] is File) {
        await simpanFotoProfile(hasil["foto"].path);
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profil berhasil diperbarui!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  // Fungsi logout
  void logout() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      const SnackBar(content: Text('Anda Berhasil logout')),
    );
  }

  // Membuka foto profil dalam mode layar penuh
  void bukaFotoPenuh(String pathFoto, bool dariFile) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Center(
              child: Hero(
                tag: 'foto_profile',
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 5.0,
                  child: dariFile
                      ? Image.file(File(pathFoto))
                      : Image.network(pathFoto),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final warnaUtama = isDark
        ? const Color.fromARGB(255, 40, 40, 40) // Warna biru untuk mode gelap
        : const Color.fromARGB(
            211, 13, 58, 181); // Warna biru untuk mode terang

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey[200],
      appBar: AppBar(
        backgroundColor: warnaUtama,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title:
            const Text('Profile Saya', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              isDark
                  ? Icons.light_mode
                  : Icons.dark_mode, // Ganti ikon berdasarkan tema
              color: Colors.white,
            ),
            onPressed: () {
              widget.onToggleTheme
                  ?.call(!isDark); // Panggil callback untuk toggle tema
            },
          ),
          // logout button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Agar halaman dapat di-scroll jika konten melebihi layar
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: warnaUtama, // Warna latar belakang utama
                    borderRadius: const BorderRadius.only(
                      // Membuat sudut bawah melengkung
                      bottomLeft:
                          Radius.circular(25), // Membulatkan sudut bawah kiri
                      bottomRight:
                          Radius.circular(25), // Membulatkan sudut bawah kanan
                    ),
                  ),
                  child: Align(
                    alignment:
                        Alignment.center, // Pusatkan konten di dalam Container
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final foto =
                                dataProfile["foto"]; // Ambil data foto profil
                            if (foto != null) {
                              bukaFotoPenuh(
                                // Buka foto dalam mode layar penuh
                                foto is File
                                    ? foto.path
                                    : foto.toString(), // Dapatkan path foto
                                foto is File,
                              );
                            }
                          },
                          child: Hero(
                            tag: "fotoProfil",
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: dataProfile["foto"] !=
                                      null // Cek apakah ada foto profil
                                  ? (dataProfile["foto"]
                                          is File // Cek apakah tipe data adalah File
                                      ? FileImage(dataProfile[
                                          "foto"]) // Gunakan FileImage jika tipe File
                                      : NetworkImage(dataProfile[
                                              "foto"]) // Gunakan NetworkImage jika tipe lainnya
                                          as ImageProvider)
                                  : const NetworkImage(
                                      "https://i.pravatar.cc/150?img=5",
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 10), // Jarak antara foto dan nama
                      ],
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  buildInfoCard("Nama Lengkap", dataProfile["nama_lengkap"]),
                  buildInfoCard("Username", dataProfile["username"]),
                  buildInfoCard("Email", dataProfile["email"]),
                  buildInfoCard("No. Telepon", dataProfile["no_telepon"]),
                  buildInfoCard("Alamat", dataProfile["alamat"]),
                  buildInfoCard("Perangkat Daerah", dataProfile["pd_nama"]),
                  buildInfoCard("Status", dataProfile["status"]),
                  buildInfoCard("Terdaftar", dataProfile["created_at"]),
                  buildInfoCard("Peran", dataProfile["role"]),
                ],
              ),
            ),
          ],
        ),
      ),

      // fungsi untuk tombol edit
      floatingActionButton: FloatingActionButton(
        onPressed: pindahKeEdit,
        backgroundColor: warnaUtama,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

//fungsi untuk membuat kartu info
  Widget buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
