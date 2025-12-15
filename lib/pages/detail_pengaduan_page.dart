import 'package:flutter/material.dart';

class DetailPengaduanPage extends StatelessWidget {
  // DITAMBAHKAN: deklarasi variabel untuk menampung data yang dikirim
  final String judul;
  final String tujuan;
  final String isi;

  // DITAMBAHKAN: konstruktor menerima data dari halaman sebelumnya
  const DetailPengaduanPage({
    super.key,
    required this.judul,
    required this.tujuan,
    required this.isi,
  });

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
                      judul,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Divider(color: theme.colorScheme.outlineVariant),
                    _buildDetailRow(context, Icons.person, "Angun"),
                    _buildDetailRow(context, Icons.email, "anggun@gmail.com"),
                    // DITAMBAHKAN: tampilkan tujuan dari parameter
                    _buildDetailRow(context, Icons.apartment, tujuan),
                    _buildDetailRow(
                        context, Icons.lock_clock, "2025-11-04 10:30:20"),
                    _buildDetailRow(context, Icons.lock, "Private"),
                    const SizedBox(height: 8),
                    //DITAMBAHKAN: tampilkan isi dari parameter
                    Text(
                      isi,
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
                    const SizedBox(height: 4),
                    Text("Belum ada tanggapapan.",
                        style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant))
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
                        "Status Terakhir: ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface),
                      ),
                      const Text(
                        "Dikirim",
                        style: TextStyle(
                          color: Colors.green,
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

  // Method untuk membangun baris detail dengan ikon dan teks
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
