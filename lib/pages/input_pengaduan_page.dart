import 'package:flutter/material.dart';

class InputPengaduanPage extends StatefulWidget {
  const InputPengaduanPage({super.key});

  @override
  State<InputPengaduanPage> createState() => _InputPengaduanPageState();
}
class _InputPengaduanPageState extends State<InputPengaduanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        title: const Text('Buat Pengaduan',
        style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Judul Pengaduan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Contoh: Jalan Rusak di Depan Sekolah',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height : 16),

              const Text('Deskripsi Permohonan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tuliskan alasan dan keperluan Anda...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height : 16),

              const Text('Tujuan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'Dinas Pekerjaan Umum', child: Text('Dinas Pekerjaan Umum')),
                  DropdownMenuItem(value: 'Dinas Kesehatan', child: Text('Dinas Kesehatan')),
                  DropdownMenuItem(value: 'Dinas Pendidikan', child: Text('Dinas Pendidikan')),
                ],
                onChanged: (value) {
                  // Logika saat tujuan dipilih
                },
                decoration: const InputDecoration(
                  labelText: 'Pilih Tujuan Pengaduan',
                  border: OutlineInputBorder(),
                ),
              ),

              const Text('Lampiran (Opsional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Lampiran',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height : 24),
              SizedBox(
                width : double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                  ),
                  onPressed: () {
                    // Logika untuk mengirim pengaduan
                  },
                  child: const Text('Kirim Pengaduan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}