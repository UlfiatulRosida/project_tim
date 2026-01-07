import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:project_tim/services/api_service.dart';

class InputPengaduanPage extends StatefulWidget {
  final VoidCallback? onSuccess;
  const InputPengaduanPage({super.key, this.onSuccess});

  @override
  State<InputPengaduanPage> createState() => _InputPengaduanPageState();
}

class _InputPengaduanPageState extends State<InputPengaduanPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  int? _idPd;
  String? _lampiran;
  String? _publikasi;
  File? _lampiranFile;
  String? _lampiranNama;

  Future<void> _pilihLampiran() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["pdf", "jpg", "png", "jpeg"],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _lampiranFile = File(result.files.single.path!);
        _lampiranNama = result.files.single.name;
        _lampiran = _lampiranNama;
        _lampiranFile;
      });
    }
  }

// submit ke api
  Future<void> _submitPengaduan() async {
    debugPrint('TOMBOL KIRIM DIKLIK');
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field yang wajib diisi'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    if (_idPd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tujuan wajib dipilih'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    if (_publikasi == null || _publikasi!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Publikasi wajib dipilih'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final result = await ApiService.createPengaduan(
        judul: _judulController.text.trim(),
        isiSurat: _deskripsiController.text.trim(),
        idPd: _idPd!,
        statusPrivasi: _publikasi!,
      );

      print('RESPONSE CREATE PENGADUAN: $result');
      Navigator.of(context).pop();
      if (result['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pengaduan berhasil dikirim'),
            backgroundColor: Colors.green,
          ),
        );

        // Reset form
        _formKey.currentState!.reset();
        _judulController.clear();
        _deskripsiController.clear();
        setState(() {
          _idPd = null;
          _publikasi = null;
          _lampiran = null;
          _lampiranFile = null;
          _lampiranNama = null;
        });

        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Gagal mengirim pengaduan'),
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);
    final outlineColor = theme.colorScheme.outlineVariant;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor:
            isDark ? theme.colorScheme.surfaceContainerHighest : primaryBlue,
        foregroundColor: isDark ? theme.colorScheme.onSurface : Colors.white,
        title: Text('Buat Pengaduan',
            style: TextStyle(
                color: isDark ? theme.colorScheme.onSurface : Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? theme.colorScheme.onSurface : Colors.white),
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
              Text(
                'Judul Pengaduan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _judulController,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Contoh: Jalan Rusak',
                  hintStyle:
                      TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: outlineColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDark ? theme.colorScheme.primary : primaryBlue,
                        width: 1),
                  ),
                ),
                validator: (value) => value!.isEmpty
                    ? 'Judul pengaduan tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Deskripsi Pengaduan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Tuliskan alasan dan keperluan Anda...',
                  hintStyle:
                      TextStyle(color: theme.colorScheme.onSurfaceVariant),
                  filled: true,
                  fillColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: outlineColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDark ? theme.colorScheme.primary : primaryBlue,
                        width: 1),
                  ),
                ),
                validator: (value) => value!.isEmpty
                    ? 'Deskripsi pengaduan tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Tujuan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                dropdownColor: isDark
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.white,
                value: _idPd,
                style: TextStyle(color: theme.colorScheme.onSurface),
                hint: Text('Pilih Tujuan Pengaduan',
                    style:
                        TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                items: const [
                  DropdownMenuItem(
                      value: 529,
                      child:
                          Text('Badan Amil Zakat Nasional Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 31,
                      child: Text(
                          'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia')),
                  DropdownMenuItem(
                      value: 34,
                      child: Text('Badan Kesatuan Bangsa dan Politik')),
                  DropdownMenuItem(
                      value: 37, child: Text('Badan Keuangan dan Aset Daerah')),
                  DropdownMenuItem(
                      value: 36, child: Text('Badan Pendapatan Daerah')),
                  DropdownMenuItem(
                      value: 33,
                      child: Text(
                          'Badan Penelitian dan pengembangan Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 32,
                      child: Text(
                          'Badan Perencanaan Pembangunan Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 48,
                      child: Text(
                          'Bagian Administrasi Kemasyarakatan dan Pembinaan Mental')),
                  DropdownMenuItem(
                      value: 532,
                      child: Text('Bagian Administrasi Pembangunan')),
                  DropdownMenuItem(value: 40, child: Text('Bagian Hukum')),
                  DropdownMenuItem(value: 42, child: Text('Bagian Kerja Sama')),
                  DropdownMenuItem(
                      value: 49, child: Text('Bagian Kesejahteraan Rakyat')),
                  DropdownMenuItem(value: 47, child: Text('Bagian Organisasi')),
                  DropdownMenuItem(
                      value: 43, child: Text('Bagian Pengadaan Barang/Jasa')),
                  DropdownMenuItem(
                      value: 41, child: Text('Bagian Perekonomian')),
                  DropdownMenuItem(
                      value: 531,
                      child: Text('Bagian Perencanaan dan Keuangan')),
                  DropdownMenuItem(
                      value: 46,
                      child: Text('Bagian Protokol & Komunikasi Pimpinan')),
                  DropdownMenuItem(
                      value: 38, child: Text('Bagian Sumber Daya Alam')),
                  DropdownMenuItem(
                      value: 39, child: Text('Bagian Tata Pemerintahan')),
                  DropdownMenuItem(value: 45, child: Text('Bagian Tata Usaha')),
                  DropdownMenuItem(value: 44, child: Text('Bagian Umum')),
                  DropdownMenuItem(value: 5, child: Text('Bupati')),
                  DropdownMenuItem(
                      value: 528,
                      child: Text('Dewan Perwakilan Rakyat Daerah')),
                  DropdownMenuItem(
                      value: 57,
                      child: Text('Dharma Wanita Persatuan Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 13,
                      child: Text('Dinas Kependudukan dan Pencatatan Sipil')),
                  DropdownMenuItem(value: 6, child: Text('Dinas Kesehatan')),
                  DropdownMenuItem(
                      value: 22, child: Text('Dinas Ketahanan Pangan')),
                  DropdownMenuItem(
                      value: 3,
                      child: Text('Dinas Komunikasi dan Informatika')),
                  DropdownMenuItem(
                      value: 19, child: Text('Dinas Koperasi dan Usaha Mikro')),
                  DropdownMenuItem(
                      value: 28, child: Text('Dinas Lingkungan Hidup')),
                  DropdownMenuItem(
                      value: 14,
                      child: Text('Dinas Pariwisata dan Kebudayaan')),
                  DropdownMenuItem(
                      value: 15,
                      child: Text('Dinas Pekerjaan Umum Bina Marga')),
                  DropdownMenuItem(
                      value: 16,
                      child: Text('Dinas Pekerjaan Umum Sumber Daya Air')),
                  DropdownMenuItem(
                      value: 25,
                      child: Text('Dinas Pemberdayaan Masyarakat dan Desa')),
                  DropdownMenuItem(
                      value: 24,
                      child: Text(
                          'Dinas Pemberdayaan Perempuan dan Perlindungan Anak')),
                  DropdownMenuItem(
                      value: 9, child: Text('Dinas Pemuda dan Olahraga')),
                  DropdownMenuItem(
                      value: 30,
                      child: Text(
                          'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu')),
                  DropdownMenuItem(value: 7, child: Text('Dinas Pendidikan')),
                  DropdownMenuItem(
                      value: 26,
                      child: Text(
                          'Dinas Pengendalian Penduduk Dan Keluarga Berencana')),
                  DropdownMenuItem(value: 12, child: Text('Dinas Perhubungan')),
                  DropdownMenuItem(value: 21, child: Text('Dinas Perikanan')),
                  DropdownMenuItem(
                      value: 18,
                      child: Text('Dinas Perindustrian Dan Perdagangan')),
                  DropdownMenuItem(
                      value: 27,
                      child: Text('Dinas perpustakaan Dan Kearsipan')),
                  DropdownMenuItem(value: 29, child: Text('Dinas Pertahanan')),
                  DropdownMenuItem(
                      value: 17,
                      child: Text(
                          'Dinas Perumahan, Kawasan Permukiman Dan Cipta Karya')),
                  DropdownMenuItem(
                      value: 23,
                      child: Text('Dinas Peternakan Dan Kesehatan Hewan')),
                  DropdownMenuItem(value: 10, child: Text('Dinas Sosial')),
                  DropdownMenuItem(
                      value: 20,
                      child: Text(
                          'Dinas Tanaman Pangan, Hortikultura Dan Perkebunan')),
                  DropdownMenuItem(
                      value: 11, child: Text('Dinas Tenaga Kerja')),
                  DropdownMenuItem(
                      value: 8, child: Text('Dprd Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 51,
                      child: Text('Inspektorat Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: 59, child: Text('Kecamatan Ampelgading')),
                  DropdownMenuItem(value: 60, child: Text('Kecamatan Bantur')),
                  DropdownMenuItem(
                      value: 61, child: Text('Kecamatan Bululawang')),
                  DropdownMenuItem(value: 62, child: Text('Kecamatan Dampit')),
                  DropdownMenuItem(value: 63, child: Text('Kecamatan Dau')),
                  DropdownMenuItem(
                      value: 64, child: Text('Kecamatan Donomulyo')),
                  DropdownMenuItem(
                      value: 66, child: Text('Kecamatan Gondanglegi')),
                  DropdownMenuItem(value: 67, child: Text('Kecamatan Jabung')),
                  DropdownMenuItem(
                      value: 68, child: Text('Kecamatan Kalipare')),
                  DropdownMenuItem(
                      value: 69, child: Text('Kecamatan Karangploso')),
                  DropdownMenuItem(
                      value: 70, child: Text('Kecamatan Kasembon')),
                  DropdownMenuItem(
                      value: 72, child: Text('Kecamatan Kromengan')),
                  DropdownMenuItem(value: 75, child: Text('Kecamatan Lawang')),
                  DropdownMenuItem(value: 76, child: Text('Kecamatan Ngajum')),
                  DropdownMenuItem(
                      value: 77, child: Text('Kecamatan Ngantang')),
                  DropdownMenuItem(value: 78, child: Text('Kecamatan Pagak')),
                  DropdownMenuItem(
                      value: 79, child: Text('Kecamatan Pagelaran')),
                  DropdownMenuItem(value: 80, child: Text('Kecamatan Pakis')),
                  DropdownMenuItem(
                      value: 81, child: Text('Kecamatan Pakisaji')),
                  DropdownMenuItem(
                      value: 82, child: Text('Kecamatan Poncokusumo')),
                  DropdownMenuItem(value: 93, child: Text('Kecamatan Pujon')),
                  DropdownMenuItem(
                      value: 84, child: Text('Kecamatan Singosari')),
                  DropdownMenuItem(
                      value: 83, child: Text('Kecamatan Sumbermanjing Wetan')),
                  DropdownMenuItem(
                      value: 85, child: Text('Kecamatan Sumberpucung')),
                  DropdownMenuItem(value: 86, child: Text('Kecamatan Tajinan')),
                  DropdownMenuItem(
                      value: 87, child: Text('Kecamatan Tirtoyudo')),
                  DropdownMenuItem(value: 88, child: Text('Kecamatan Tumpang')),
                  DropdownMenuItem(value: 89, child: Text('Kecamatan Turen')),
                  DropdownMenuItem(value: 90, child: Text('Kecamatan Wagir')),
                  DropdownMenuItem(value: 91, child: Text('Kecamatan Wajak')),
                  DropdownMenuItem(
                      value: 92, child: Text('Kecamatan Wonosari')),
                  DropdownMenuItem(
                      value: 137, child: Text('Kelurahan Ardirejo')),
                  DropdownMenuItem(
                      value: 143, child: Text('Kelurahan Candirenggo')),
                  DropdownMenuItem(
                      value: 138, child: Text('Kelurahan Cepokomulyo')),
                  DropdownMenuItem(value: 136, child: Text('Kelurahan Dampit')),
                  DropdownMenuItem(
                      value: 141, child: Text('Kelurahan Kalirejo')),
                  DropdownMenuItem(
                      value: 139, child: Text('Kelurahan Kepanjen')),
                  DropdownMenuItem(value: 142, child: Text('Kelurahan Lawang')),
                  DropdownMenuItem(value: 144, child: Text('Kelurahan Losari')),
                  DropdownMenuItem(
                      value: 145, child: Text('Kelurahan Pagentan')),
                  DropdownMenuItem(value: 146, child: Text('Kelurahan Sedayu')),
                  DropdownMenuItem(value: 147, child: Text('Kelurahan Turen')),
                  DropdownMenuItem(
                      value: 536, child: Text('Komando Diatrik Militer 0818')),
                  DropdownMenuItem(
                      value: 53,
                      child: Text('Pemberdayaan Dan Kesejahteraan Keluarga')),
                  DropdownMenuItem(value: 4, child: Text('Ppid Kominfo')),
                  DropdownMenuItem(
                      value: 56,
                      child: Text('Pt Bpr Artha Kanjuruhan Pemkab Malang')),
                  DropdownMenuItem(
                      value: 108, child: Text('Puskesmas Ampelgading')),
                  DropdownMenuItem(
                      value: 129, child: Text('Puskesmas Ardimulyo')),
                  DropdownMenuItem(value: 100, child: Text('Puskesmas Bantur')),
                  DropdownMenuItem(value: 105, child: Text('Puskesmas Dampit')),
                  DropdownMenuItem(value: 131, child: Text('Puskesmas Dau')),
                  DropdownMenuItem(
                      value: 96, child: Text('Puskesmas Donomulyo')),
                  DropdownMenuItem(
                      value: 102, child: Text('Puskesmas Gedangan')),
                  DropdownMenuItem(
                      value: 113, child: Text('Puskesmas Gondanglegi')),
                  DropdownMenuItem(value: 126, child: Text('Puskesmas Jabung')),
                  DropdownMenuItem(
                      value: 97, child: Text('Puskesmas Kalipare')),
                  DropdownMenuItem(
                      value: 130, child: Text('Puskesmas Karang ploso')),
                  DropdownMenuItem(
                      value: 134, child: Text('Puskesmas Kasembon')),
                  DropdownMenuItem(
                      value: 116, child: Text('Puskesmas Kepanjen')),
                  DropdownMenuItem(
                      value: 114, child: Text('Puskesmas Ketawang')),
                  DropdownMenuItem(
                      value: 118, child: Text('Puskesmas Kromengan')),
                  DropdownMenuItem(value: 127, child: Text('Puskesmas Lawang')),
                  DropdownMenuItem(value: 119, child: Text('Puskesmas Ngajum')),
                  DropdownMenuItem(
                      value: 133, child: Text('Puskesmas Ngantang')),
                  DropdownMenuItem(value: 98, child: Text('Puskesmas Pagak')),
                  DropdownMenuItem(
                      value: 115, child: Text('Puskesmas Pagelaran')),
                  DropdownMenuItem(value: 125, child: Text('Puskesmas Pakis')),
                  DropdownMenuItem(
                      value: 106, child: Text('Puskesmas Pamotan')),
                  DropdownMenuItem(
                      value: 109, child: Text('Puskesmas Poncokusumo')),
                  DropdownMenuItem(value: 132, child: Text('Puskesmas Pujon')),
                  DropdownMenuItem(
                      value: 128, child: Text('Puskesmas Singosari')),
                  DropdownMenuItem(
                      value: 103, child: Text('Puskesmas Sitiarjo')),
                  DropdownMenuItem(value: 104, child: Text('Puskesmas Sumawe')),
                  DropdownMenuItem(
                      value: 99, child: Text('Puskesmas Sumbermanjing Kulon')),
                  DropdownMenuItem(
                      value: 117, child: Text('Puskesmas Sumberpucung')),
                  DropdownMenuItem(
                      value: 123, child: Text('Puskesmas Tajinan')),
                  DropdownMenuItem(
                      value: 107, child: Text('Puskesmas Tirtoyudo')),
                  DropdownMenuItem(
                      value: 124, child: Text('Puskesmas Tumpang')),
                  DropdownMenuItem(value: 111, child: Text('Puskesmas Turen')),
                  DropdownMenuItem(value: 121, child: Text('Puskesmas Wagir')),
                  DropdownMenuItem(value: 110, child: Text('Puskesmas Wajak')),
                  DropdownMenuItem(
                      value: 101, child: Text('Puskesmas Wonokerto')),
                  DropdownMenuItem(
                      value: 120, child: Text('Puskesmas Wonosari')),
                  DropdownMenuItem(value: 50, child: Text('Rsud Kanjuruhan')),
                  DropdownMenuItem(value: 58, child: Text('Rsud Lawang')),
                  DropdownMenuItem(value: 525, child: Text('Rsud Ngantang')),
                  DropdownMenuItem(value: 527, child: Text('Satgas Covid-19')),
                  DropdownMenuItem(
                      value: 52, child: Text('Satuan Polisi Pamong Praja')),
                  DropdownMenuItem(
                      value: 533, child: Text('Sekretariat Daerah')),
                  DropdownMenuItem(value: 534, child: Text('Staf Ahli')),
                  DropdownMenuItem(value: 1, child: Text('Tidak Ada')),
                  DropdownMenuItem(
                      value: 94, child: Text('Upt Laboratorium Kesehatan')),
                  DropdownMenuItem(
                      value: 135,
                      child:
                          Text('Upt Pengujian Dan Kalibrasi Alat Kesehatan')),
                  DropdownMenuItem(
                      value: 112, child: Text('Upt Puskesmas Bululawang')),
                ],
                onChanged: (value) {
                  setState(() {
                    _idPd = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: outlineColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDark ? theme.colorScheme.primary : primaryBlue,
                        width: 1),
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Pilih tujuan pengaduan' : null,
              ),
              const SizedBox(height: 16),
              Text(
                'Lampiran (Opsional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pilihLampiran,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.white,
                    border: Border.all(color: outlineColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _lampiran ?? 'Pilih File',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      Icon(Icons.attach_file,
                          color: theme.colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Publikasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                dropdownColor: isDark
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.white,
                value: _publikasi,
                hint: Text('Pilih Publikasi',
                    style:
                        TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                items: const [
                  DropdownMenuItem(value: 'Public', child: Text('Public')),
                  DropdownMenuItem(value: 'Private', child: Text('Private')),
                ],
                onChanged: (value) => setState(() => _publikasi = value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: outlineColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: isDark ? theme.colorScheme.primary : primaryBlue,
                        width: 1),
                  ),
                ),
                validator: (value) =>
                    value == null ? 'Pilih jenis publikasi' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? theme.colorScheme.onSurface.withAlpha(204)
                        : primaryBlue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _submitPengaduan,
                  child: Text(
                    'Kirim',
                    style: TextStyle(
                        fontSize: 16, color: theme.colorScheme.onPrimary),
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
