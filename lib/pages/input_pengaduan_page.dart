
import 'package:flutter/material.dart';

class InputPengaduanPage extends StatefulWidget {
  const InputPengaduanPage({super.key});

  @override
  State<InputPengaduanPage> createState() => _InputPengaduanPageState();
}
class _InputPengaduanPageState extends State<InputPengaduanPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lampiranController = TextEditingController();

  String? _tujuan;
  String? _lampiran;
  String? _publikasi;
  
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
          key: _formKey,
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
                controller: _judulController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Jalan Rusak',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
              ),
              validator: (value) => value!.isEmpty ? 'Judul pengaduan tidak boleh kosong' : null,
              ),
              const SizedBox(height : 16),

              const Text('Deskripsi Pengaduan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tuliskan alasan dan keperluan Anda...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
              ),
              validator: (value) => value!.isEmpty ? 'Deskripsi pengaduan tidak boleh kosong' : null,
              ),
              const SizedBox(height : 16),

              const Text('Tujuan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _tujuan,
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
                  DropdownMenuItem(value: 'Kelurahan Ardirejo', child: Text('Kelurahan Ardirejo')),
                  DropdownMenuItem(value: 'Kelurahan Candirenggo', child: Text('Kelurahan Candirenggo')),
                  DropdownMenuItem(value: 'Kelurahan Cepokomulyo', child: Text('Kelurahan Cepokomulyo')),
                  DropdownMenuItem(value: 'Kelurahan Dampit', child: Text('Kelurahan Dampit')),
                  DropdownMenuItem(value: 'Kelurahan Kalirejo', child: Text('Kelurahan Kalirejo')),
                  DropdownMenuItem(value: 'Kelurahan Kepanjen', child: Text('Kelurahan Kepanjen')),
                  DropdownMenuItem(value: 'Kelurahan Lawang', child: Text('Kelurahan Lawang')),
                  DropdownMenuItem(value: 'Kelurahan Losari', child: Text('Kelurahan Losari')),
                  DropdownMenuItem(value: 'Kelurahan Pagentan', child: Text('Kelurahan Pagentan')),
                  DropdownMenuItem(value: 'Kelurahan Sedayu', child: Text('Kelurahan Sedayu')),
                  DropdownMenuItem(value: 'Kelurahan Turen', child: Text('Kelurahan Turen')),
                  DropdownMenuItem(value: 'Komando Diatrik Militer 0818', child: Text('Komando Diatrik Militer 0818')),
                  DropdownMenuItem(value: 'Pemberdayaan Dan Kesejahteraan Keluarga', child: Text('Pemberdayaan Dan Kesejahteraan Keluarga')),
                  DropdownMenuItem(value: 'Ppid Kominfo', child: Text('Kecamatan Pakisaji')),
                  DropdownMenuItem(value: 'Pt Bpr Artha Kanjuruhan Pemkab Malang', child: Text('Pt Bpr Artha Kanjuruhan Pemkab Malang')),
                  DropdownMenuItem(value: 'Puskesmas Ampelgading', child: Text('Puskesmas Ampelgading')),
                  DropdownMenuItem(value: 'Puskesmas Ardimulyo', child: Text('Puskesmas Ardimulyo')),
                  DropdownMenuItem(value: 'Puskesmas Bantur', child: Text('Puskesmas Bantur')),
                  DropdownMenuItem(value: 'Puskesmas Dampit', child: Text('Puskesmas Dampit')),
                  DropdownMenuItem(value: 'Puskesmas Dau', child: Text('Puskesmas Dau')),
                  DropdownMenuItem(value: 'Puskesmas Donomulyo', child: Text('Puskesmas Donomulyo')),
                  DropdownMenuItem(value: 'Puskesmas Gedangan', child: Text('Puskesmas Gedangan')),
                  DropdownMenuItem(value: 'Puskesmas Gondanglegi', child: Text('Puskesmas Gondanglegi')),
                  DropdownMenuItem(value: 'Puskesmas Jabung', child: Text('Puskesmas Jabung')),
                  DropdownMenuItem(value: 'Puskesmas Kalipare', child: Text('Puskesmas Kalipare')),
                  DropdownMenuItem(value: 'Puskesmas Karang ploso', child: Text('Puskesmas Karang ploso')),
                  DropdownMenuItem(value: 'Puskesmas Kasembon', child: Text('Puskesmas Kasembon')),
                  DropdownMenuItem(value: 'Puskesmas Kepanjen', child: Text('Puskesmas Kepanjen')),
                  DropdownMenuItem(value: 'Puskesmas Ketawang', child: Text('Puskesmas Ketawang')),
                  DropdownMenuItem(value: 'Puskesmas Kromengan', child: Text('Puskesmas Kromengan')),
                  DropdownMenuItem(value: 'Puskesmas Lawang', child: Text('Puskesmas Lawang')),
                  DropdownMenuItem(value: 'Puskesmas Ngajung', child: Text('Puskesmas Ngajung')),
                  DropdownMenuItem(value: 'Puskesmas Ngantang', child: Text('Puskesmas Ngantang')),
                  DropdownMenuItem(value: 'Puskesmas Pagak', child: Text('Puskesmas Pagak')),
                  DropdownMenuItem(value: 'Puskesmas Pagelaran', child: Text('Puskesmas Pagelaran')),
                  DropdownMenuItem(value: 'Puskesmas Pakis', child: Text('Puskesmas Pakis')),
                  DropdownMenuItem(value: 'Puskesmas Pamotan', child: Text('Puskesmas Pamotan')),
                  DropdownMenuItem(value: 'Puskesmas Poncokusumo', child: Text('Puskesmas Poncokusumo')),
                  DropdownMenuItem(value: 'Puskesmas Pujon', child: Text('Puskesmas Pujon')),
                  DropdownMenuItem(value: 'Puskesmas Singosari', child: Text('Puskesmas Singosari')),
                  DropdownMenuItem(value: 'Puskesmas Sitiarjo', child: Text('Puskesmas Sitiarjo')),
                  DropdownMenuItem(value: 'Puskesmas Sumawe', child: Text('Puskesmas Sumawe')),
                  DropdownMenuItem(value: 'Puskesmas Sumbermanjing Kulon', child: Text('Puskesmas Sumbermanjing Kulon')),
                  DropdownMenuItem(value: 'Puskesmas Sumberpucung', child: Text('Puskesmas Sumberpucung')),
                  DropdownMenuItem(value: 'Puskesmas Tajinan', child: Text('Puskesmas Tajinan')),
                  DropdownMenuItem(value: 'Puskesmas Tirtoyudo', child: Text('Puskesmas Tirtoyudo')),
                  DropdownMenuItem(value: 'Puskesmas Tumpang', child: Text('Puskesmas Tumpang')),
                  DropdownMenuItem(value: 'Puskesmas Turen', child: Text('Puskesmas Turen')),
                  DropdownMenuItem(value: 'Puskesmas Wagir', child: Text('Puskesmas Wagir')),
                  DropdownMenuItem(value: 'Puskesmas Wajak', child: Text('Puskesmas Wajak')),
                  DropdownMenuItem(value: 'Puskesmas Wonokerto', child: Text('Puskesmas Wonokerto')),
                  DropdownMenuItem(value: 'Puskesmas Wonosari', child: Text('Puskesmas Wonosari')),
                  DropdownMenuItem(value: 'Rsud Kanjuruhan', child: Text('Rsud Kanjuruhan')),
                  DropdownMenuItem(value: 'Rsud Lawang', child: Text('Rsud Lawang')),
                  DropdownMenuItem(value: 'Rsud Ngantang', child: Text('Rsud Ngantang')),
                  DropdownMenuItem(value: 'Satgas Covid-19', child: Text('Satgas Covid-19')),
                  DropdownMenuItem(value: 'Satuan Polisi Pamong Praja', child: Text('Satuan Polisi Pamong Praja')),
                  DropdownMenuItem(value: 'Sekretariat Daerah', child: Text('Sekretariat Daerah')),
                  DropdownMenuItem(value: 'Staf Ahli', child: Text('Staf Ahli')),
                  DropdownMenuItem(value: 'Tidak Ada', child: Text('Tidak Ada')),
                  DropdownMenuItem(value: 'Upt Laboratorium Kesehatan', child: Text('Upt Laboratorium Kesehatan')),
                  DropdownMenuItem(value: 'Upt Pengujian Dan Kalibrasi Atau Kesehatan', child: Text('Upt Pengujian Dan Kalibrasi Atau Kesehatan')),
                  DropdownMenuItem(value: 'Upt Puskesmas Bululawang', child: Text('Upt Puskesmas Bululawang')),
                ],
                onChanged: (value) {
                  setState(() {
                    _tujuan = value;
                  });
                  // Logika saat tujuan dipilih
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0C0C0C), width : 1),
                ),
              ),
              validator: (value) => value == null ? 'Pilih tujuan pengaduan' : null,
              ),
              const SizedBox(height : 16),

              const Text('Lampiran (Opsional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),
              InkWell(
                onTap: () {
                  setState(() {
                    _lampiran = 'dokumen_pengaduan.pdf';
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _lampiran ?? 'Pilih File',
                        style: const TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      const Icon(Icons.attach_file, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height : 16),

              const Text('Publikasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height : 8),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.white,
                value: _publikasi,
                hint: const Text('Pilih Publikasi'),
                items: const [
                  DropdownMenuItem(value: 'Publik', child: Text('Publik')),
                  DropdownMenuItem(value: 'Privat', child: Text('Privat')),
                ],
                onChanged: (value) => setState(() => _publikasi = value),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFF0C0C0C), width : 1),
                  ),
                ),
                validator: (value) => value == null ? 'Pilih jenis publikasi' : null,
              ),

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
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pengaduan berhasil dikirim!'),
                          backgroundColor: Colors.green,
                        ),
                      );// Proses pengiriman pengaduan
                      _formKey.currentState!.reset();
                      _judulController.clear();
                      _deskripsiController.clear();
                      _lampiranController.clear();
                      setState(() {
                        _tujuan = null;
                        _lampiran = null;
                      });
                    }
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