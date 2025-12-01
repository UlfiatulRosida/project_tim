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
                  DropdownMenuItem(value: 'Badan Amil Zakat Nasional Kabupaten Malang', child: Text('Badan Amil Zakat Nasional Kabupaten Malang')),
                  DropdownMenuItem(value: 'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia', child: Text('Badan Kepegawaian dan Pengembangan Sumber Daya Manusia')),
                  DropdownMenuItem(value: 'Badan Kesatuan Bangsa dan Politik', child: Text('Badan Kesatuan Bangsa dan Politik')),
                  DropdownMenuItem(value: 'Badan Keuangan dan Aset Daerah', child: Text('Badan Keuangan dan Aset Daerah')),
                  DropdownMenuItem(value: 'Badan Pendapatan Daerah', child: Text('Badan Pendapatan Daerah')),
                  DropdownMenuItem(value: 'Badan Penelitian dan pengembangan Daerah Kabupaten Malang', child: Text('Badan Penelitian dan pengembangan Daerah Kabupaten Malang')),
                  DropdownMenuItem(value: 'Badan Perencanaan Pembangunan Daerah Kabupaten Malang', child: Text('Badan Perencanaan Pembangunan Daerah Kabupaten Malang')),
                  DropdownMenuItem(value: 'Bagian Administrasi Kemasyarakatan dan Pembinaan Mental', child: Text('Bagian Administrasi Kemasyarakatan dan Pembinaan Mental')),
                  DropdownMenuItem(value: 'Bagian Administrasi Pembangunan', child: Text('Bagian Administrasi Pembangunan')),
                  DropdownMenuItem(value: 'Bagian Hukum', child: Text('Bagian Hukum')),
                  DropdownMenuItem(value: 'Bagian Kerja Sama', child: Text('Bagian Kerja Sama')),
                  DropdownMenuItem(value: 'Bagian Kesejahteraan Rakyat', child: Text('Bagian Kesejahteraan Rakyat')),
                  DropdownMenuItem(value: 'Bagian Organisasi', child: Text('Bagian Organisasi')),
                  DropdownMenuItem(value: 'Bagian Pengadaan Barang/Jasa', child: Text('Bagian Pengadaan Barang/Jasa')),
                  DropdownMenuItem(value: 'Bagian Perekonomian', child: Text('Bagian Perekonomian')),
                  DropdownMenuItem(value: 'Bagian Perencanaan dan Keuangan', child: Text('Bagian Perencanaan dan Keuangan')),
                  DropdownMenuItem(value: 'Bagian Protokol dan Komunikasi Pimpinan', child: Text('Bagian Protokol dan Komunikasi Pimpinan')), 
                  DropdownMenuItem(value: 'Bagian Sumber Daya Alam', child: Text('Bagian Sumber Daya Alam')),
                  DropdownMenuItem(value: 'Bagian Tata Pemerintahan', child: Text('Bagian Tata Pemerintahan')),
                  DropdownMenuItem(value: 'Bagian Tata Usaha', child: Text('Bagian Tata Usaha')),
                  DropdownMenuItem(value: 'Bagian Umum', child: Text('Bagian Umum')),
                  DropdownMenuItem(value: 'Bupati', child: Text('Bupati')),
                  DropdownMenuItem(value: 'Dewan Perwakilan Rakyat Daerah', child: Text('Bagian Kerja Sama')),
                  DropdownMenuItem(value: 'Dharma Wanita Persatuan Kabupaten Malang', child: Text('Dharma Wanita Persatuan Kabupaten Malang')),
                  DropdownMenuItem(value: 'Dinas Kependudukan dan Pencatatan Sipil', child: Text('Dinas Kependudukan dan Pencatatan Sipil')),
                  DropdownMenuItem(value: 'Dinas Kesehatan', child: Text('Dinas Kesehatan')),
                  DropdownMenuItem(value: 'Dinas Ketahanan Pangan', child: Text('Dinas Ketahanan Pangan')),
                  DropdownMenuItem(value: 'Dinas Komunikasi dan Informatika', child: Text('Dinas Komunikasi dan Informatika')),
                  DropdownMenuItem(value: 'Dinas Koperasi dan Usaha Mikro', child: Text('Dinas Koperasi dan Usaha Mikro')),
                  DropdownMenuItem(value: 'Dinas Lingkungan Hidup', child: Text('Dinas Lingkungan Hidup')),
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