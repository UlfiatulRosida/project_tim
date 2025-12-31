// import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_tim/pages/login_page.dart';
import 'package:project_tim/services/api_service.dart';
import 'edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HalamanProfile extends StatefulWidget {
  final Function(bool)? onToggleTheme;

  const HalamanProfile({super.key, this.onToggleTheme});

  @override
  State<HalamanProfile> createState() => _HalamanProfileState();
}

class _HalamanProfileState extends State<HalamanProfile> {
  // bool temaGelap = false;
  bool _isloading = true;
  String _error = '';

  Map<String, dynamic> dataProfile = {
    //Map<String, dynamic> dataProfile = {
    "nama_lengkap": "-",
    "username": "-",
    "email": "-",
    "no_telepon": "-",
    "alamat": "-",
    "pd_nama": "-",
    "status": "-",
    "created_at": "-",
    "role": "-",
    "foto": null,
  };

  // "nama_lengkap": "Anggun",
  // "username": "anggun",
  // "email": "anggun123@gmail.com",
  // "no_telepon": "+62 831-8140-000",
  // "alamat": "Jl. Melati No. 45, Malang",
  // "pd_nama": "1",
  // "status": "Aktif",
  // "created_at": "12 Januari 2024, 12:23:45",
  // "role": "warga",
  // "foto": null,
  //};

  File? fotoProfile;

// Menyimpan path foto profil ke SharedPreferences
  Future<void> simpanFotoProfile(String pathFoto) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('path_foto_profil', pathFoto);
  }

  // Mengambil path foto profil dari SharedPreferences saat inisialisasi
  Future<void> ambilFotoProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final pathFoto = prefs.getString('path_foto_profil');
    if (pathFoto != null) {
      setState(() {
        fotoProfile = File(pathFoto);
        dataProfile["foto"] = fotoProfile;
      });
    }
  }

  Future<void> _getProfile() async {
    final result = await ApiService.getProfile();

    print('Profile API Result: $result');

    if (!mounted) return;

    if (result['success'] == true) {
      final user = result['data']['user'];

      setState(() {
        dataProfile = {
          "nama_lengkap": user['nama_lengkap'] ?? '-',
          "username": user['username'] ?? '-',
          "email": user['email'] ?? '-',
          "no_telepon": user['no_telepon'] ?? '-',
          "alamat": user['alamat'] ?? '-',
          "pd_nama": user['id_pd']?.toString() ?? '-',
          "status": user['status'] == 10 ? 'Aktif' : 'Non-Aktif',
          "created_at": user['created_at'] ??
              user['tanggal_daftar'] ??
              user['registered_at'] ??
              '-',
          "role": user['peran'] == 10 ? 'Non-Warga' : 'Warga',
          "foto": null, // foto lokal
        };
        _isloading = false;
      });
    } else {
      setState(() {
        _isloading = false;
        _error = result['message'] ?? 'Gagal mengambil data profile';
      });
    }
  }

  // Inisialisasi state
  @override
  void initState() {
    super.initState();
    ambilFotoProfile();
    _getProfile();
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
    final rootContext = context;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.surface,
              title: const Text("Konfirmasi Logout"),
              content: const Text("Apakah anda yakin ingin keluar"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Anda berhasil keluar"),
                      backgroundColor: Colors.green,
                    ));
                    await Future.delayed(const Duration(milliseconds: 600));
                    Navigator.of(rootContext).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  child: const Text("Logout"),
                ),
              ],
            ));
    // ScaffoldMessenger.of(
    //   context,
    // ).showSnackBar(
    //   const SnackBar(content: Text('Anda Berhasil logout')),
    // );
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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
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
    if (_isloading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(_error),
        ),
      );
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final warnaUtama = isDark
        ? theme
            .colorScheme.surfaceContainerHighest // Warna biru untuk mode gelap
        : const Color(0xFF1565C0); // Warna biru untuk mode terang

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: warnaUtama,
        foregroundColor: isDark ? theme.colorScheme.onSurface : Colors.white,
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
              color: isDark ? theme.colorScheme.onSurface : Colors.white,
            ),
            onPressed: () {
              widget.onToggleTheme
                  ?.call(!isDark); // Panggil callback untuk toggle tema
            },
          ),
          // logout button
          IconButton(
            icon: Icon(
              Icons.logout,
              color: isDark ? theme.colorScheme.onSurface : Colors.white,
            ),
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
                  height: 220,
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
                              backgroundColor: theme.colorScheme.surface,
                              backgroundImage: dataProfile["foto"] !=
                                      null // Cek apakah ada foto profil
                                  ? (dataProfile["foto"]
                                          is File // Cek apakah tipe data adalah File
                                      ? FileImage(dataProfile[
                                          "foto"]) // Gunakan FileImage jika tipe File
                                      : NetworkImage(dataProfile[
                                              "foto"]) // Gunakan NetworkImage jika tipe lainnya
                                          as ImageProvider)
                                  : null,
                              child: dataProfile["foto"] == null
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: theme.colorScheme.onSurface,
                                    )
                                  : null,
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
                  buildInfoCard("Nama Lengkap", dataProfile["nama_lengkap"],
                      theme, isDark),
                  buildInfoCard(
                      "Username", dataProfile["username"], theme, isDark),
                  buildInfoCard("Email", dataProfile["email"], theme, isDark),
                  buildInfoCard(
                      "No. Telepon", dataProfile["no_telepon"], theme, isDark),
                  buildInfoCard("Alamat", dataProfile["alamat"], theme, isDark),
                  buildInfoCard("Perangkat Daerah", dataProfile["pd_nama"],
                      theme, isDark),
                  buildInfoCard("Status", dataProfile["status"], theme, isDark),
                  buildInfoCard(
                      "Terdaftar", dataProfile["created_at"], theme, isDark),
                  buildInfoCard("Peran", dataProfile["role"], theme, isDark),
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
  Widget buildInfoCard(
      String title, String value, ThemeData theme, bool isDark) {
    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            color: isDark ? Colors.grey[300] : Colors.grey[800],
          ),
        ),
      ),
    );
  }
}
