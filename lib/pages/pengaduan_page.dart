import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_tim/services/api_service.dart';
import 'detail_pengaduan_page.dart';
import 'input_pengaduan_page.dart';

class PengaduanPage extends StatefulWidget {
  const PengaduanPage({super.key, this.onBackToHome});
  final VoidCallback? onBackToHome;

  @override
  State<PengaduanPage> createState() => _PengaduanPageState();
}

class _PengaduanPageState extends State<PengaduanPage> {
  List<dynamic> _pengaduan = [];
  bool _isLoading = true;
  String _error = '';
  String _selectedStatus = 'Semua';

  int _currentPage = 1;
  int _selectedEntries = 5;
  final List<int> _entriesOptions = [5, 10, 20, 50];

  @override
  void initState() {
    super.initState();
    _loadPengaduan();
  }

  Future<void> _loadPengaduan() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    final result = await ApiService.getPengaduan();

    if (result['success'] == true) {
      setState(() {
        final rawData = result['data'];

        if (rawData is Map) {
          if (rawData.containsKey('data') && rawData['data'] is List) {
            _pengaduan = rawData['data'];
          } else {
            //(rawData is List) {
            _pengaduan = [];
            _error = 'Data pengaduan tidak ditemukan';
          }
        } else if (rawData is List) {
          _pengaduan = rawData;
        } else if (rawData == null) {
          _pengaduan = [];
          _error = 'Data dari api bernilai null';
        } else {
          _pengaduan = [];
          _error = 'Format data pengaduan tidak dikenali';
        }

        _currentPage = 1;
        _isLoading = false;
        _selectedStatus = 'Semua';
        // _pengaduan = result['data'] is Map
        //     ? result['data']['data'] ?? []
        //     : result['data'];
        // _isLoading = false;
      });
    } else {
      setState(() {
        _error = result['message'] ?? 'Gagal mengambil data pengaduan';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);

// loading dan error handling
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error.isNotEmpty) {
      return Scaffold(
        body: Center(child: Text(_error)),
      );
    }

// Pagination logic

    List<dynamic> filteredPengaduan = _pengaduan;
    if (_selectedStatus != 'Semua') {
      filteredPengaduan = _pengaduan.where((pengaduan) {
        final status = pengaduan['status_privasi'] ?? pengaduan['status'];
        return status == _selectedStatus;
      }).toList();
    }
    final int totalPages =
        (_pengaduan.length / _selectedEntries).ceil().clamp(1, 999);

    final int startIndex = (_currentPage - 1) * _selectedEntries;

    final int endIndex =
        (_currentPage * _selectedEntries).clamp(0, _pengaduan.length);

    final displayedComplaints = startIndex < filteredPengaduan.length
        ? filteredPengaduan.sublist(startIndex, endIndex)
        : <dynamic>[];

    // final List<Map<String, String>> allComplaints = [
    //   {
    //     'judul': 'Jalan Berlubang',
    //     'tujuan': 'Dinas Tenaga Kerja',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-01'
    //   },
    //   {
    //     'judul': 'Lampu Jalan Mati',
    //     'tujuan': 'Dinas Perhubungan',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-28'
    //   },
    //   {
    //     'judul': 'Sampah Menumpuk',
    //     'tujuan': 'Dinas Kebersihan',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-03'
    //   },
    //   {
    //     'judul': 'Air PDAM Mati',
    //     'tujuan': 'Dinas PU',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-30'
    //   },
    //   {
    //     'judul': 'Kebisingan dari Tempat Hiburan',
    //     'tujuan': 'Dinas Pariwisata',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-02'
    //   },
    //   {
    //     'judul': 'Trotoar Rusak',
    //     'tujuan': 'Dinas Perhubungan',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-29'
    //   },
    //   {
    //     'judul': 'Pohon Tumbang',
    //     'tujuan': 'Dinas Lingkungan Hidup',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-04'
    //   },
    //   {
    //     'judul': 'Sungai Tercemar',
    //     'tujuan': 'Dinas Lingkungan Hidup',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-27'
    //   },
    //   {
    //     'judul': 'Parkir Liar',
    //     'tujuan': 'Dinas Perhubungan',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-05'
    //   },
    //   {
    //     'judul': 'Kebocoran Gas',
    //     'tujuan': 'Dinas Pemadam Kebakaran',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-26'
    //   },
    //   {
    //     'judul': 'Gangguan Lalu Lintas',
    //     'tujuan': 'Dinas Perhubungan',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-06'
    //   },
    //   {
    //     'judul': 'Kebersihan Taman Kota',
    //     'tujuan': 'Dinas Kebersihan',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-25'
    //   },
    //   {
    //     'judul': 'Pengangkutan Sampah Tidak Teratur',
    //     'tujuan': 'Dinas Kebersihan',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-07'
    //   },
    //   {
    //     'judul': 'Kerusakan Fasilitas Umum',
    //     'tujuan': 'Dinas PU',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-24'
    //   },
    //   {
    //     'judul': 'Kebisingan Konstruksi',
    //     'tujuan': 'Dinas PU',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-08'
    //   },
    //   {
    //     'judul': 'Pencemaran Udara',
    //     'tujuan': 'Dinas Lingkungan Hidup',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-23'
    //   },
    //   {
    //     'judul': 'Kebocoran Air Bersih',
    //     'tujuan': 'Dinas PU',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-09'
    //   },
    //   {
    //     'judul': 'Kerusakan Jembatan',
    //     'tujuan': 'Dinas PU',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-22'
    //   },
    //   {
    //     'judul': 'Gangguan Kebisingan dari Industri',
    //     'tujuan': 'Dinas Perindustrian',
    //     'status': 'Dalam Proses',
    //     'tanggal': '2024-06-10'
    //   },
    //   {
    //     'judul': 'Pelanggaran Parkir',
    //     'tujuan': 'Dinas Perhubungan',
    //     'status': 'Selesai',
    //     'tanggal': '2024-05-21'
    //   },
    // ];

    // int totalPages = (allComplaints.length / _selectedEntries).ceil();
    // int startIndex = (_currentPage - 1) * _selectedEntries;
    // int endIndex = (_currentPage * _selectedEntries);
    // if (endIndex > allComplaints.length) endIndex = allComplaints.length;

    // final displayedComplaints = allComplaints.sublist(startIndex, endIndex);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor:
            isDark ? theme.colorScheme.surfaceContainerHighest : primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? theme.colorScheme.onSurface : Colors.white),
          onPressed: () {
            if (widget.onBackToHome != null) {
              widget.onBackToHome!();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text('Pengaduan',
            style: TextStyle(
                color: isDark ? theme.colorScheme.onSurface : Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark ? theme.colorScheme.primary : primaryBlue,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InputPengaduanPage(),
            ),
          );
          if (result == true) {
            await _loadPengaduan();
          }
          // Aksi ketika tombol FAB ditekan
          // belum ditambahkan navigasi ke halaman tambah pengaduan karena belum dibuat
        },
        child: Icon(Icons.add,
            color: isDark ? theme.colorScheme.onPrimary : Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter dan Entries Dropdown
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: Border.all(
                      color: isDark
                          ? theme.colorScheme.outlineVariant
                          : Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(children: [
                  Text(
                    'Jumlah Pengaduan Saya',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface),
                  ),
                  const Spacer(),
                  Text(
                    _pengaduan.length.toString(),
                    style: TextStyle(
                        fontSize: 16, color: theme.colorScheme.onSurface),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              // Dropdown Status
              Text('Status',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  border: Border.all(
                      color: isDark
                          ? theme.colorScheme.outlineVariant
                          : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  dropdownColor: isDark
                      ? theme.colorScheme.surfaceContainerHighest
                      : Colors.white,
                  underline: const SizedBox(),
                  value: _selectedStatus,
                  isExpanded: true,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  items: const [
                    DropdownMenuItem(value: 'Semua', child: Text('Semua')),
                    DropdownMenuItem(value: 'Public', child: Text('Publik')),
                    DropdownMenuItem(value: 'Private', child: Text('Privat')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedStatus = value;
                      _currentPage = 1;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              //Show Entries
              Row(
                children: [
                  Text('Show',
                      style: TextStyle(color: theme.colorScheme.onSurface)),
                  const SizedBox(width: 10),
                  Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? theme.colorScheme.surfaceContainerHighest
                          : Colors.white,
                      border: Border.all(
                          color: isDark
                              ? theme.colorScheme.outlineVariant
                              : Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<int>(
                      dropdownColor: isDark
                          ? theme.colorScheme.surfaceContainerHighest
                          : Colors.white,
                      value: _selectedEntries,
                      underline: const SizedBox(),
                      style: TextStyle(color: theme.colorScheme.onSurface),
                      items: _entriesOptions
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedEntries = value;
                            _currentPage = 1;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('entries',
                      style: TextStyle(color: theme.colorScheme.onSurface)),
                ],
              ),
              const SizedBox(height: 20),
              // Daftar Pengaduan
              Card(
                color: isDark
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.white,
                elevation: isDark ? 0 : 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: isDark
                                ? theme.colorScheme.outlineVariant
                                : Colors.grey,
                            width: 0.3),
                      )),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('Judul',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface)),
                          ),
                          Expanded(
                            child: Text('Tujuan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface)),
                          ),
                          Expanded(
                            child: Text('Aksi',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface)),
                          ),
                        ],
                      ),
                    ),
                    ...displayedComplaints.map(
                      (item) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Row(children: [
                          Expanded(
                            child: Text(
                              item['judul']?.toString() ?? '-',
                              style: TextStyle(
                                fontSize: 13,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                                item['pd']?['nama_pd']?.toString() ??
                                    item['nm_opd']?.toString() ??
                                    '-',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface)),
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPengaduanPage(
                                            judul: item['judul'] ?? '-',
                                            tujuan:
                                                item['pd']?['nama_pd'] ?? '-',
                                            isi: item['isi_surat'] ?? '-',
                                          ),
                                        ));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size(60, 30),
                                    side: BorderSide(
                                        color: isDark
                                            ? theme.colorScheme.primary
                                            : primaryBlue),
                                  ),
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(
                                        color: isDark
                                            ? theme.colorScheme.primary
                                            : primaryBlue,
                                        fontSize: 12),
                                  ),
                                )),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Pagination
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    color: _currentPage > 1
                        ? (isDark ? theme.colorScheme.primary : primaryBlue)
                        : theme.disabledColor,
                    onPressed: _currentPage > 1
                        ? () {
                            setState(() {
                              _currentPage--;
                            });
                          }
                        : null,
                  ),
                  Text(
                    '$_currentPage / $totalPages',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    color: _currentPage < totalPages
                        ? (isDark ? theme.colorScheme.primary : primaryBlue)
                        : theme.disabledColor,
                    onPressed: _currentPage < totalPages
                        ? () {
                            setState(() {
                              _currentPage++;
                            });
                          }
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
