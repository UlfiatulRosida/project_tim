import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputPengaduanPage extends StatefulWidget {
  const InputPengaduanPage({super.key});

  @override
  State<InputPengaduanPage> createState() => _InputPengaduanPageState();
}
class _InputPengaduanPageState extends State<InputPengaduanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              const SizedBox(height : 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Contoh: Jalan Rusak',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
              ),
              ),
              const SizedBox(height : 16),

              const Text('Deskripsi Permohonan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Tuliskan alasan dan keperluan Anda...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
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
                hint: const Text('Pilih Tujuan Pengaduan'),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
              ),
              ),
              const SizedBox(height : 16),

              const Text('Lampiran (Opsional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),

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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Logika untuk mengirim pengaduan
                  },
                  child: const Text('Kirim',style: TextStyle(fontSize: 16,color:Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}