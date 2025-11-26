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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //card Utama
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      judul,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height : 8),
                    const Divider(),
                    _buildDetailRow(Icons.person, "Angun"),
                    _buildDetailRow(Icons.email, "anggun@gmail.com"), 
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  // Method untuk membangun baris detail dengan ikon dan teks
  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width : 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      )
    );
  }
}