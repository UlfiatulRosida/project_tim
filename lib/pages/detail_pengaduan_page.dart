import 'package:flutter/material.dart';
import 'package:project_tim/services/api_service.dart';

class DetailPengaduanPage extends StatefulWidget {
  final Map<String, dynamic> pengaduan;

  const DetailPengaduanPage({
    super.key,
    required this.pengaduan,
  });

  @override
  State<DetailPengaduanPage> createState() => _DetailPengaduanPageState();
}

class _DetailPengaduanPageState extends State<DetailPengaduanPage> {
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final res = await ApiService.getProfile();
    if (res['success'] == true) {
      setState(() {
        user = res['data']['user'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);
    return Scaffold(
      backgroundColor: isDark ? theme.colorScheme.surface : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isDark ? theme.colorScheme.surfaceContainerHighest : primaryBlue,
        foregroundColor: isDark ? theme.colorScheme.onSurface : Colors.white,
        elevation: 0,
        title: Text(
          'Detail Pengaduan',
          style: TextStyle(
              color: isDark ? theme.colorScheme.onSurface : Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? theme.colorScheme.onSurface : Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //card Utama
            Card(
              color: isDark
                  ? theme.colorScheme.surfaceContainerHighest
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pengaduan['judul'] ?? '-',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Divider(color: theme.colorScheme.outlineVariant),
                    _buildDetailRow(
                        context, Icons.person, user?['nama_lengkap'] ?? '-'),
                    _buildDetailRow(
                        context, Icons.email, user?['email'] ?? '-'),
                    // DITAMBAHKAN: tampilkan tujuan dari parameter
                    _buildDetailRow(context, Icons.apartment,
                        widget.pengaduan['nm_opd']?.toString() ?? '-'),
                    _buildDetailRow(context, Icons.lock_clock,
                        widget.pengaduan['created_at']?.toString() ?? '-'),
                    _buildDetailRow(
                      context,
                      Icons.lock,
                      widget.pengaduan['status'] == 'Private'
                          ? 'Private'
                          : 'Public',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.pengaduan['isi_surat'] ?? '-',
                      style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // card tanggapan
            Card(
              color: isDark
                  ? theme.colorScheme.surfaceContainerHighest
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tanggapan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (widget.pengaduan['tanggapan_terakhir'] != null &&
                        widget.pengaduan['tanggapan_terakhir']
                            .toString()
                            .isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pengaduan['tanggapan_terakhir'],
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.pengaduan['tanggapan_waktu'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      )
                    else
                      Text(
                        "Belum ada tanggapan.",
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // card starus terakhir
            Card(
              color: isDark
                  ? theme.colorScheme.surfaceContainerHighest
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Terakhir',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Text(
                        "Dikirim",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: 12),
            // card Lampiran
            Card(
              color: isDark
                  ? theme.colorScheme.surfaceContainerHighest
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lampiran",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface),
                    ),
                    const SizedBox(height: 4),
                    Text("Tidak ada lampiran",
                        style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style:
                  TextStyle(fontSize: 14, color: theme.colorScheme.onSurface),
            ),
          ),
        ],
      ),
    );
  }
}
