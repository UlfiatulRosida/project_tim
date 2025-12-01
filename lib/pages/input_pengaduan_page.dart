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
                  DropdownMenuItem(value: 'Dinas Pariwisata dan Kebudayaan', child: Text('Dinas Pariwisata dan Kebudayaan')),
                  DropdownMenuItem(value: 'Dinas Pekerjaan Umum Bina Marga', child: Text('Dinas Pekerjaan Umum Bina Marga')),
                  DropdownMenuItem(value: 'Dinas Pekerjaan Umum Sumber Daya Air', child: Text('Dinas Pekerjaan Umum Sumber Daya Air')),
                  DropdownMenuItem(value: 'Dinas Pemberdayaan Masyarakat dan Desa', child: Text('Dinas Pemberdayaan Masyarakat dan Desa')),
                  DropdownMenuItem(value: 'Dinas Pemberdayaan Perempuan dan Perlindungan Anak', child: Text('Dinas Pemberdayaan Perempuan dan Perlindungan Anak')),
                  DropdownMenuItem(value: 'Dinas Pemuda dan Olahraga', child: Text('Dinas Pemuda dan Olahraga')),
                  DropdownMenuItem(value: 'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu', child: Text('Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu')),
                  DropdownMenuItem(value: 'Dinas Pendidikan', child: Text('Dinas Pendidikan')),
                  DropdownMenuItem(value: 'Dinas Pengendalian Penduduk Dan Keluarga Berencana', child: Text('Dinas Pengendalian Penduduk Dan Keluarga Berencana')),
                  DropdownMenuItem(value: 'Dinas Perhubungan', child: Text('Dinas Perhubungan')),
                  DropdownMenuItem(value: 'Dinas Perikanan', child: Text('Dinas Perikanan')),
                  DropdownMenuItem(value: 'Dinas Perindustrian Dan Perdagangan', child: Text('Dinas Perindustrian Dan Perdagangan')),
                  DropdownMenuItem(value: 'Dinas perpustakaan Dan Kearsipan', child: Text('Dinas perpustakaan Dan Kearsipan')),
                  DropdownMenuItem(value: 'Dinas Pertahanan', child: Text('Dinas Pertahanan')),
                  DropdownMenuItem(value: 'Dinas Perumahan, Kawasan Permukiman Dan Cipta Karya', child: Text('Dinas Perumahan, Kawasan Permukiman Dan Cipta Karya')),
                  DropdownMenuItem(value: 'Dinas Peternakan Dan Kesehatan Hewan', child: Text('Dinas Peternakan Dan Kesehatan Hewan')),
                  DropdownMenuItem(value: 'Dinas Sosial', child: Text('Dinas Sosial')),
                  DropdownMenuItem(value: 'Dinas Tanaman Pangan, Hortikultura Dan Perkebunan', child: Text('Dinas Tanaman Pangan, Hortikultura Dan Perkebunan')),
                  DropdownMenuItem(value: 'Dinas Tenaga Kerja', child: Text('Dinas Tenaga Kerja')),
                  DropdownMenuItem(value: 'Dprd Kabupaten Malang', child: Text('Dprd Kabupaten Malang')),
                  DropdownMenuItem(value: 'Inspektorat Daerah Kabupaten Malang', child: Text('Inspektorat Daerah Kabupaten Malang')),
                  DropdownMenuItem(value: 'Kecamatan Ampelgading', child: Text('Kecamatan Ampelgading')),
                  DropdownMenuItem(value: 'Kecamatan Bantur', child: Text('Kecamatan Bantur')),
                  DropdownMenuItem(value: 'Kecamatan Bululawang', child: Text('Kecamatan Bululawang')),
                  DropdownMenuItem(value: 'Kecamatan Dampit', child: Text('Kecamatan Dampit')),
                  DropdownMenuItem(value: 'Kecamatan Dau', child: Text('Kecamatan Dau')),
                  DropdownMenuItem(value: 'Kecamatan Donomulyo', child: Text('Kecamatan Donomulyo')),
                  DropdownMenuItem(value: 'Kecamatan Gondanglegi', child: Text('Kecamatan Gondanglegi')),
                  DropdownMenuItem(value: 'Kecamatan Jabung', child: Text('Kecamatan Jabung')),
                  DropdownMenuItem(value: 'Kecamatan Kalipare', child: Text('Kecamatan Kalipare')),
                  DropdownMenuItem(value: 'Kecamatan Karangploso', child: Text('Kecamatan Karangploso')),
                  DropdownMenuItem(value: 'Kecamatan Kasembon', child: Text('Kecamatan Kasembon')),
                  DropdownMenuItem(value: 'Kecamatan Kromengan', child: Text('Kecamatan Kromengan')),
                  DropdownMenuItem(value: 'Kecamatan Lawang', child: Text('Kecamatan Lawang')),
                  DropdownMenuItem(value: 'Kecamatan Ngajum', child: Text('Kecamatan Ngajum')),
                  DropdownMenuItem(value: 'Kecamatan Ngantang', child: Text('Kecamatan Ngantang')),
                  DropdownMenuItem(value: 'Kecamatan Pagak', child: Text('Kecamatan Pagak')),
                  DropdownMenuItem(value: 'Kecamatan Pagelaran', child: Text('Kecamatan Pagelaran')),
                  DropdownMenuItem(value: 'Kecamatan Pakis', child: Text('Kecamatan Pakis')),
                  DropdownMenuItem(value: 'Kecamatan Pakisaji', child: Text('Kecamatan Pakisaji')),
                  DropdownMenuItem(value: 'Kecamatan Poncokusumo', child: Text('Kecamatan Poncokusumo')),
                  DropdownMenuItem(value: 'Kecamatan Pujon', child: Text('Kecamatan Pujon')),
                  DropdownMenuItem(value: 'Kecamatan Singosari', child: Text('Kecamatan Singosari')),
                  DropdownMenuItem(value: 'Kecamatan Sumbermanjing Wetan', child: Text('Kecamatan Sumbermanjing Wetan')),
                  DropdownMenuItem(value: 'Kecamatan Sumberpucung', child: Text('Kecamatan Sumberpucung')),
                  DropdownMenuItem(value: 'Kecamatan Tajinan', child: Text('Kecamatan Tajinan')),
                  DropdownMenuItem(value: 'Kecamatan Tirtoyudo', child: Text('Kecamatan Tirtoyudo')),
                  DropdownMenuItem(value: 'Kecamatan Tumpang', child: Text('Kecamatan Tumpang')),
                  DropdownMenuItem(value: 'Kecamatan Turen', child: Text('Kecamatan Turen')),
                  DropdownMenuItem(value: 'Kecamatan Wagir', child: Text('Kecamatan Wagir')),
                  DropdownMenuItem(value: 'Kecamatan Wajak', child: Text('Kecamatan Wajak')),
                  DropdownMenuItem(value: 'Kecamatan Wonosari', child: Text('Kecamatan Wonosari')),
                   

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