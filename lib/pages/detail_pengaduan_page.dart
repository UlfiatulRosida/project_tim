import 'package:flutter/material.dart';

class DetailPengaduanPage extends StatelessWidget {
  // DITAMBAHKAN: deklarasi variabel untuk menampung data yang dikirim
  final String judul; 
  final String tujuan;
  final String isi;

  // DITAMBAHKAN: konstruktor menerima data dari halaman sebelumnya
  const DetailPengaduanPage({
    super.key,
    required this.judul,
    required this.tujuan,
    required this.isi,
  });




@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
        title: const Text('Detail Pengaduan',
        style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text('Halaman Detail Pengaduan'),
      ),
    );
  }
}