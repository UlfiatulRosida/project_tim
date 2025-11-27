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
        style: TextStyle(color: Colors.white),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Judul Pengaduan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height : 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tujuan Pengaduan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height : 16),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Isi Pengaduan',
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