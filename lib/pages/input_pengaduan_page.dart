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
  //final TextEditingController _publikasiController = TextEditingController();

  String? _tujuan;
  // final String _statusPrivasi = 'Public'; // Default ke 'Publik'
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
    // if (!_formKey.currentState!.validate()) return;
    // final isValid = _formKey.currentState?.validate() ?? false;
    //   if (!isValid) return;
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field yang wajib diisi'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // ← STOP di sini kalau form tidak valid
    }
    // if (_tujuan == null || _tujuan!.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Tujuan wajib dipilih')),
    //   );
    //   return;
    // }
    if (_tujuan == null || _tujuan!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tujuan wajib dipilih'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // ← STOP di sini kalau tujuan kosong
    }

    //validasi tipe data tujuan
    if (int.tryParse(_tujuan!) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tujuan tidak valid'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // ← STOP di sini kalau tujuan tidak valid
    }

    if (_publikasi == null || _publikasi!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Publikasi wajib dipilih'),
          backgroundColor: Colors.orange,
        ),
      );
      return; // ← STOP di sini kalau publikasi kosong
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // 5. KIRIM DATA KE API
      final result = await ApiService.createPengaduan(
        judul: _judulController.text.trim(),
        isiSurat: _deskripsiController.text.trim(),
        idPd: int.parse(_tujuan!),
        statusPrivasi: _publikasi!, // ← Gunakan value dari dropdown publikasi
      );
      // final result = await ApiService.createPengaduan(
      //   judul: _judulController.text,
      //   isiSurat: _deskripsiController.text,
      //   idPd: int.parse(_tujuan!),
      //   statusPrivasi: _statusPrivasi,
      // );
      // final payload = {
      //   'judul': _judulController.text,
      //   'isi_pengaduan': _deskripsiController.text,
      //   'tujuan': _tujuan,
      //   'status_privasi': _statusPrivasi,
      // };

      // final result = await ApiService.createPengaduan(
      //   payload,
      //   judul: '',
      //   isi: '',
      // );
      // 6. TUTUP LOADING
      //if (mounted)
      Navigator.of(context).pop(); // Tutup loading

      //if (!mounted) return;

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
          _tujuan = null;
          _publikasi = null;
          _lampiran = null;
          _lampiranFile = null;
          _lampiranNama = null;
        });

        Navigator.pop(context, true);
        widget.onSuccess?.call();
        // widget.onSuccess?.call();
        // if (mounted) {
        //   Navigator.pop(context, true);
        // }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Gagal mengirim pengaduan'),
          ),
        );
      }
    } catch (e) {
      // ERROR
      if (mounted) Navigator.pop(context); // Tutup loading

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
          // duration: const Duration(seconds: 3),
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
                  color: theme.colorScheme.surface,
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
              DropdownButtonFormField<String>(
                dropdownColor: isDark
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.white,
                value: _tujuan,
                style: TextStyle(color: theme.colorScheme.onSurface),
                hint: Text('Pilih Tujuan Pengaduan',
                    style:
                        TextStyle(color: theme.colorScheme.onSurfaceVariant)),
                items: const [
                  DropdownMenuItem(
                      // value: 'Badan Amil Zakat Nasional Kabupaten Malang',
                      value: '1',
                      child:
                          Text('Badan Amil Zakat Nasional Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '2',
                      child: Text(
                          'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia')),
                  DropdownMenuItem(
                      value: '3',
                      child: Text('Badan Kesatuan Bangsa dan Politik')),
                  DropdownMenuItem(
                      value: '4',
                      child: Text('Badan Keuangan dan Aset Daerah')),
                  DropdownMenuItem(
                      value: '5', child: Text('Badan Pendapatan Daerah')),
                  DropdownMenuItem(
                      value: '6',
                      child: Text(
                          'Badan Penelitian dan pengembangan Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '7',
                      child: Text(
                          'Badan Perencanaan Pembangunan Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '8',
                      child: Text(
                          'Bagian Administrasi Kemasyarakatan dan Pembinaan Mental')),
                  DropdownMenuItem(
                      value: '9',
                      child: Text('Bagian Administrasi Pembangunan')),
                  DropdownMenuItem(value: '10', child: Text('Bagian Hukum')),
                  DropdownMenuItem(
                      value: '11', child: Text('Bagian Kerja Sama')),
                  DropdownMenuItem(
                      value: '12', child: Text('Bagian Kesejahteraan Rakyat')),
                  DropdownMenuItem(
                      value: '13', child: Text('Bagian Organisasi')),
                  DropdownMenuItem(
                      value: '14', child: Text('Bagian Pengadaan Barang/Jasa')),
                  DropdownMenuItem(
                      value: '15', child: Text('Bagian Perekonomian')),
                  DropdownMenuItem(
                      value: '16',
                      child: Text('Bagian Perencanaan dan Keuangan')),
                  DropdownMenuItem(
                      value: '17',
                      child: Text('Bagian Protokol dan Komunikasi Pimpinan')),
                  DropdownMenuItem(
                      value: '18', child: Text('Bagian Sumber Daya Alam')),
                  DropdownMenuItem(
                      value: '19', child: Text('Bagian Tata Pemerintahan')),
                  DropdownMenuItem(
                      value: '20', child: Text('Bagian Tata Usaha')),
                  DropdownMenuItem(value: '21', child: Text('Bagian Umum')),
                  DropdownMenuItem(value: '22', child: Text('Bupati')),
                  DropdownMenuItem(
                      value: '22',
                      child: Text('Dewan Perwakilan Rakyat Daerah')),
                  DropdownMenuItem(
                      value: '23',
                      child: Text('Dharma Wanita Persatuan Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '24',
                      child: Text('Dinas Kependudukan dan Pencatatan Sipil')),
                  DropdownMenuItem(value: '25', child: Text('Dinas Kesehatan')),
                  DropdownMenuItem(
                      value: '26', child: Text('Dinas Ketahanan Pangan')),
                  DropdownMenuItem(
                      value: '27',
                      child: Text('Dinas Komunikasi dan Informatika')),
                  DropdownMenuItem(
                      value: '28',
                      child: Text('Dinas Koperasi dan Usaha Mikro')),
                  DropdownMenuItem(
                      value: '29', child: Text('Dinas Lingkungan Hidup')),
                  DropdownMenuItem(
                      value: '30',
                      child: Text('Dinas Pariwisata dan Kebudayaan')),
                  DropdownMenuItem(
                      value: '31',
                      child: Text('Dinas Pekerjaan Umum Bina Marga')),
                  DropdownMenuItem(
                      value: '32',
                      child: Text('Dinas Pekerjaan Umum Sumber Daya Air')),
                  DropdownMenuItem(
                      value: '33',
                      child: Text('Dinas Pemberdayaan Masyarakat dan Desa')),
                  DropdownMenuItem(
                      value: '34',
                      child: Text(
                          'Dinas Pemberdayaan Perempuan dan Perlindungan Anak')),
                  DropdownMenuItem(
                      value: '35', child: Text('Dinas Pemuda dan Olahraga')),
                  DropdownMenuItem(
                      value: '36',
                      child: Text(
                          'Dinas Penanaman Modal dan Pelayanan Terpadu Satu Pintu')),
                  DropdownMenuItem(
                      value: '37', child: Text('Dinas Pendidikan')),
                  DropdownMenuItem(
                      value: '38',
                      child: Text(
                          'Dinas Pengendalian Penduduk Dan Keluarga Berencana')),
                  DropdownMenuItem(
                      value: '39', child: Text('Dinas Perhubungan')),
                  DropdownMenuItem(value: '40', child: Text('Dinas Perikanan')),
                  DropdownMenuItem(
                      value: '41',
                      child: Text('Dinas Perindustrian Dan Perdagangan')),
                  DropdownMenuItem(
                      value: '42',
                      child: Text('Dinas perpustakaan Dan Kearsipan')),
                  DropdownMenuItem(
                      value: '43', child: Text('Dinas Pertahanan')),
                  DropdownMenuItem(
                      value: '44',
                      child: Text(
                          'Dinas Perumahan, Kawasan Permukiman Dan Cipta Karya')),
                  DropdownMenuItem(
                      value: '45',
                      child: Text('Dinas Peternakan Dan Kesehatan Hewan')),
                  DropdownMenuItem(value: '46', child: Text('Dinas Sosial')),
                  DropdownMenuItem(
                      value: '47',
                      child: Text(
                          'Dinas Tanaman Pangan, Hortikultura Dan Perkebunan')),
                  DropdownMenuItem(
                      value: '48', child: Text('Dinas Tenaga Kerja')),
                  DropdownMenuItem(
                      value: '49', child: Text('Dprd Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '50',
                      child: Text('Inspektorat Daerah Kabupaten Malang')),
                  DropdownMenuItem(
                      value: '51', child: Text('Kecamatan Ampelgading')),
                  DropdownMenuItem(
                      value: '52', child: Text('Kecamatan Bantur')),
                  DropdownMenuItem(
                      value: '53', child: Text('Kecamatan Bululawang')),
                  DropdownMenuItem(
                      value: '54', child: Text('Kecamatan Dampit')),
                  DropdownMenuItem(value: '55', child: Text('Kecamatan Dau')),
                  DropdownMenuItem(
                      value: '56', child: Text('Kecamatan Donomulyo')),
                  DropdownMenuItem(
                      value: '57', child: Text('Kecamatan Gondanglegi')),
                  DropdownMenuItem(
                      value: '58', child: Text('Kecamatan Jabung')),
                  DropdownMenuItem(
                      value: '59', child: Text('Kecamatan Kalipare')),
                  DropdownMenuItem(
                      value: '60', child: Text('Kecamatan Karangploso')),
                  DropdownMenuItem(
                      value: '61', child: Text('Kecamatan Kasembon')),
                  DropdownMenuItem(
                      value: '62', child: Text('Kecamatan Kromengan')),
                  DropdownMenuItem(
                      value: '63', child: Text('Kecamatan Lawang')),
                  DropdownMenuItem(
                      value: '64', child: Text('Kecamatan Ngajum')),
                  DropdownMenuItem(
                      value: '65', child: Text('Kecamatan Ngantang')),
                  DropdownMenuItem(value: '66', child: Text('Kecamatan Pagak')),
                  DropdownMenuItem(
                      value: '67', child: Text('Kecamatan Pagelaran')),
                  DropdownMenuItem(value: '68', child: Text('Kecamatan Pakis')),
                  DropdownMenuItem(
                      value: '69', child: Text('Kecamatan Pakisaji')),
                  DropdownMenuItem(
                      value: '70', child: Text('Kecamatan Poncokusumo')),
                  DropdownMenuItem(value: '71', child: Text('Kecamatan Pujon')),
                  DropdownMenuItem(
                      value: '72', child: Text('Kecamatan Singosari')),
                  DropdownMenuItem(
                      value: '73',
                      child: Text('Kecamatan Sumbermanjing Wetan')),
                  DropdownMenuItem(
                      value: '74', child: Text('Kecamatan Sumberpucung')),
                  DropdownMenuItem(
                      value: '75', child: Text('Kecamatan Tajinan')),
                  DropdownMenuItem(
                      value: '76', child: Text('Kecamatan Tirtoyudo')),
                  DropdownMenuItem(
                      value: '77', child: Text('Kecamatan Tumpang')),
                  DropdownMenuItem(value: '78', child: Text('Kecamatan Turen')),
                  DropdownMenuItem(value: '79', child: Text('Kecamatan Wagir')),
                  DropdownMenuItem(value: '80', child: Text('Kecamatan Wajak')),
                  DropdownMenuItem(
                      value: '81', child: Text('Kecamatan Wonosari')),
                  DropdownMenuItem(
                      value: '82', child: Text('Kelurahan Ardirejo')),
                  DropdownMenuItem(
                      value: '83', child: Text('Kelurahan Candirenggo')),
                  DropdownMenuItem(
                      value: '84', child: Text('Kelurahan Cepokomulyo')),
                  DropdownMenuItem(
                      value: '85', child: Text('Kelurahan Dampit')),
                  DropdownMenuItem(
                      value: '86', child: Text('Kelurahan Kalirejo')),
                  DropdownMenuItem(
                      value: '87', child: Text('Kelurahan Kepanjen')),
                  DropdownMenuItem(
                      value: '88', child: Text('Kelurahan Lawang')),
                  DropdownMenuItem(
                      value: '89', child: Text('Kelurahan Losari')),
                  DropdownMenuItem(
                      value: '90', child: Text('Kelurahan Pagentan')),
                  DropdownMenuItem(
                      value: '91', child: Text('Kelurahan Sedayu')),
                  DropdownMenuItem(value: '92', child: Text('Kelurahan Turen')),
                  DropdownMenuItem(
                      value: '93', child: Text('Komando Diatrik Militer 0818')),
                  DropdownMenuItem(
                      value: '94',
                      child: Text('Pemberdayaan Dan Kesejahteraan Keluarga')),
                  DropdownMenuItem(
                      value: 'Ppid Kominfo', child: Text('Kecamatan Pakisaji')),
                  DropdownMenuItem(
                      value: 'Pt Bpr Artha Kanjuruhan Pemkab Malang',
                      child: Text('Pt Bpr Artha Kanjuruhan Pemkab Malang')),
                  DropdownMenuItem(
                      value: 'Puskesmas Ampelgading',
                      child: Text('Puskesmas Ampelgading')),
                  DropdownMenuItem(
                      value: 'Puskesmas Ardimulyo',
                      child: Text('Puskesmas Ardimulyo')),
                  DropdownMenuItem(
                      value: 'Puskesmas Bantur',
                      child: Text('Puskesmas Bantur')),
                  DropdownMenuItem(
                      value: 'Puskesmas Dampit',
                      child: Text('Puskesmas Dampit')),
                  DropdownMenuItem(
                      value: 'Puskesmas Dau', child: Text('Puskesmas Dau')),
                  DropdownMenuItem(
                      value: 'Puskesmas Donomulyo',
                      child: Text('Puskesmas Donomulyo')),
                  DropdownMenuItem(
                      value: 'Puskesmas Gedangan',
                      child: Text('Puskesmas Gedangan')),
                  DropdownMenuItem(
                      value: 'Puskesmas Gondanglegi',
                      child: Text('Puskesmas Gondanglegi')),
                  DropdownMenuItem(
                      value: 'Puskesmas Jabung',
                      child: Text('Puskesmas Jabung')),
                  DropdownMenuItem(
                      value: 'Puskesmas Kalipare',
                      child: Text('Puskesmas Kalipare')),
                  DropdownMenuItem(
                      value: 'Puskesmas Karang ploso',
                      child: Text('Puskesmas Karang ploso')),
                  DropdownMenuItem(
                      value: 'Puskesmas Kasembon',
                      child: Text('Puskesmas Kasembon')),
                  DropdownMenuItem(
                      value: 'Puskesmas Kepanjen',
                      child: Text('Puskesmas Kepanjen')),
                  DropdownMenuItem(
                      value: 'Puskesmas Ketawang',
                      child: Text('Puskesmas Ketawang')),
                  DropdownMenuItem(
                      value: 'Puskesmas Kromengan',
                      child: Text('Puskesmas Kromengan')),
                  DropdownMenuItem(
                      value: 'Puskesmas Lawang',
                      child: Text('Puskesmas Lawang')),
                  DropdownMenuItem(
                      value: 'Puskesmas Ngajung',
                      child: Text('Puskesmas Ngajung')),
                  DropdownMenuItem(
                      value: 'Puskesmas Ngantang',
                      child: Text('Puskesmas Ngantang')),
                  DropdownMenuItem(
                      value: 'Puskesmas Pagak', child: Text('Puskesmas Pagak')),
                  DropdownMenuItem(
                      value: 'Puskesmas Pagelaran',
                      child: Text('Puskesmas Pagelaran')),
                  DropdownMenuItem(
                      value: 'Puskesmas Pakis', child: Text('Puskesmas Pakis')),
                  DropdownMenuItem(
                      value: 'Puskesmas Pamotan',
                      child: Text('Puskesmas Pamotan')),
                  DropdownMenuItem(
                      value: 'Puskesmas Poncokusumo',
                      child: Text('Puskesmas Poncokusumo')),
                  DropdownMenuItem(
                      value: 'Puskesmas Pujon', child: Text('Puskesmas Pujon')),
                  DropdownMenuItem(
                      value: 'Puskesmas Singosari',
                      child: Text('Puskesmas Singosari')),
                  DropdownMenuItem(
                      value: 'Puskesmas Sitiarjo',
                      child: Text('Puskesmas Sitiarjo')),
                  DropdownMenuItem(
                      value: 'Puskesmas Sumawe',
                      child: Text('Puskesmas Sumawe')),
                  DropdownMenuItem(
                      value: 'Puskesmas Sumbermanjing Kulon',
                      child: Text('Puskesmas Sumbermanjing Kulon')),
                  DropdownMenuItem(
                      value: 'Puskesmas Sumberpucung',
                      child: Text('Puskesmas Sumberpucung')),
                  DropdownMenuItem(
                      value: 'Puskesmas Tajinan',
                      child: Text('Puskesmas Tajinan')),
                  DropdownMenuItem(
                      value: 'Puskesmas Tirtoyudo',
                      child: Text('Puskesmas Tirtoyudo')),
                  DropdownMenuItem(
                      value: 'Puskesmas Tumpang',
                      child: Text('Puskesmas Tumpang')),
                  DropdownMenuItem(
                      value: 'Puskesmas Turen', child: Text('Puskesmas Turen')),
                  DropdownMenuItem(
                      value: 'Puskesmas Wagir', child: Text('Puskesmas Wagir')),
                  DropdownMenuItem(
                      value: 'Puskesmas Wajak', child: Text('Puskesmas Wajak')),
                  DropdownMenuItem(
                      value: 'Puskesmas Wonokerto',
                      child: Text('Puskesmas Wonokerto')),
                  DropdownMenuItem(
                      value: 'Puskesmas Wonosari',
                      child: Text('Puskesmas Wonosari')),
                  DropdownMenuItem(
                      value: 'Rsud Kanjuruhan', child: Text('Rsud Kanjuruhan')),
                  DropdownMenuItem(
                      value: 'Rsud Lawang', child: Text('Rsud Lawang')),
                  DropdownMenuItem(
                      value: 'Rsud Ngantang', child: Text('Rsud Ngantang')),
                  DropdownMenuItem(
                      value: 'Satgas Covid-19', child: Text('Satgas Covid-19')),
                  DropdownMenuItem(
                      value: 'Satuan Polisi Pamong Praja',
                      child: Text('Satuan Polisi Pamong Praja')),
                  DropdownMenuItem(
                      value: 'Sekretariat Daerah',
                      child: Text('Sekretariat Daerah')),
                  DropdownMenuItem(
                      value: 'Staf Ahli', child: Text('Staf Ahli')),
                  DropdownMenuItem(
                      value: 'Tidak Ada', child: Text('Tidak Ada')),
                  DropdownMenuItem(
                      value: 'Upt Laboratorium Kesehatan',
                      child: Text('Upt Laboratorium Kesehatan')),
                  DropdownMenuItem(
                      value: 'Upt Pengujian Dan Kalibrasi Atau Kesehatan',
                      child:
                          Text('Upt Pengujian Dan Kalibrasi Atau Kesehatan')),
                  DropdownMenuItem(
                      value: 'Upt Puskesmas Bululawang',
                      child: Text('Upt Puskesmas Bululawang')),
                ],
                onChanged: (value) {
                  setState(() {
                    _tujuan = value;
                  });
                  // Logika saat tujuan dipilih
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
                // onTap: () {
                //   setState(() {
                //     _lampiran = 'dokumen_pengaduan.pdf';
                //   });
                // },
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
                  DropdownMenuItem(value: 'Public', child: Text('Publik')),
                  DropdownMenuItem(value: 'Private', child: Text('Privat')),
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
                  onPressed: _submitPengaduan, // mengirim ke pengaduan api
                  // onPressed: () {
                  //   if (_formKey.currentState!.validate()) {
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(
                  //         content: Text('Pengaduan berhasil dikirim!'),
                  //         backgroundColor: Colors.green,
                  //       ),
                  //     ); // Proses pengiriman pengaduan
                  //     _formKey.currentState!.reset();
                  //     _judulController.clear();
                  //     _deskripsiController.clear();
                  //     //_publikasiController.clear();
                  //     setState(() {
                  //       _tujuan = null;
                  //       _lampiran = null;
                  //     });
                  //     Navigator.pop(context, true);
                  //     widget.onSuccess?.call();
                  //   }
                  // },
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
