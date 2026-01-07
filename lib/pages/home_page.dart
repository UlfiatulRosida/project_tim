import 'package:flutter/material.dart';
import 'package:project_tim/services/api_service.dart';
import 'package:project_tim/services/auth_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> complaints = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _jumlahKeluhan = 0;
  int _keluhanSelesai = 0;

  String _namaUser = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadData();
  }

  Future<void> _loadUser() async {
    final user = await AuthPrefs.getUser();

    debugPrint('USER DARI PREFS (HOME): $user');

    if (user != null) {
      setState(() {
        _namaUser = user['username'] ?? '';
        debugPrint('Nama User: $_namaUser');
      });
    }
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final result = await ApiService.getPengaduan();
      debugPrint('Response API: $result');

      if (result['success'] == true) {
        final data = result['data'];
        if (data is Map && data['data'] is List) {
          complaints = List.from(data['data']);
        } else if (data is List) {
          complaints = List.from(data);
        } else {
          throw Exception('Format data pengaduan tidak valid');
        }
        _jumlahKeluhan = complaints.length;
        _keluhanSelesai = complaints.where((complaint) {
          final tanggapan =
              complaint['tanggapan_admin'] ?? complaint['tanggapan_terakhir'];
          return tanggapan != null && tanggapan.toString().isNotEmpty;
        }).length;
      } else {
        _errorMessage = result['message'] ?? 'Gagal mengambil data pengaduan';
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : primaryBlue,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Surat Warga',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _namaUser.isNotEmpty
                          ? 'Selamat datang, $_namaUser'
                          : 'Selamat datang',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Statistik Keluhan
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: isDark
                              ? theme.colorScheme.surfaceContainerHighest
                              : Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(Icons.mail_outline,
                                    color: theme.colorScheme.primary),
                                const SizedBox(height: 8),
                                Text(
                                  'Jumlah Pengaduan saya',
                                  style: TextStyle(
                                      color: theme.colorScheme.onSurface),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$_jumlahKeluhan',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          color: isDark
                              ? theme.colorScheme.surfaceContainerHighest
                              : Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Icon(Icons.check_circle_outline,
                                    color: theme.colorScheme.primary),
                                const SizedBox(height: 8),
                                Text(
                                  'Pengaduan Selesai',
                                  style: TextStyle(
                                      color: theme.colorScheme.onSurface),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$_keluhanSelesai',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Gambar info berita malang
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Image.network(
                    'https://malangkab.go.id',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text('Gagal memuat gambar');
                    },
                  ),
                ),
                // Daftar Pengaduan
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    color: isDark
                        ? theme.colorScheme.surfaceContainerHighest
                        : Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        if (_isLoading)
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          )
                        else if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: complaints.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 1,
                              color: theme.colorScheme.outlineVariant,
                            ),
                            itemBuilder: (context, index) {
                              final complaint = complaints[index];
                              final bool sudahDitanggapi =
                                  (complaint['tanggapan_admin'] != null &&
                                          complaint['tanggapan_admin']
                                              .toString()
                                              .trim()
                                              .isNotEmpty) ||
                                      (complaint['tanggapan_terakhir'] !=
                                              null &&
                                          complaint['tanggapan_terakhir']
                                              .toString()
                                              .trim()
                                              .isNotEmpty);
                              return InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        margin: const EdgeInsets.only(
                                            top: 6, right: 12),
                                        decoration: BoxDecoration(
                                          color: sudahDitanggapi
                                              ? Colors.green
                                              : Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    complaint['judul']
                                                            ?.toString() ??
                                                        '-',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  complaint['created_at']
                                                          ?.toString() ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              complaint['nm_opd']?.toString() ??
                                                  '-',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              complaint['tanggapan_terakhir'] !=
                                                          null &&
                                                      complaint[
                                                              'tanggapan_terakhir']
                                                          .toString()
                                                          .isNotEmpty
                                                  ? complaint[
                                                      'tanggapan_terakhir']
                                                  : '(Dalam Proses)',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
