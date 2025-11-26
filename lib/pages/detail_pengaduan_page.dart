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
      appBar: AppBar(
        title: const Text('Detail Pengaduan'),
      ),
      body: const Center(
        child: Text('Halaman Detail Pengaduan'),
      ),
    );
  }
}