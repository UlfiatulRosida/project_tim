import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final complaints = [
    //   {
    //     'Judul': 'Jalan Berlubang',
    //     'Tujuan': 'Dinas Tenaga Kerja',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-01',
    //   },
    //   {
    //     'Judul': 'Lampu Jalan Mati',
    //     'Tujuan': 'Dinas Perhubungan',
    //     'Tanggapan': '(Selesai)',
    //     'Tanggal': '2024-05-28',
    //   },
    //   {
    //     'Judul': 'Sampah Menumpuk',
    //     'Tujuan': 'Dinas Kebersihan',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-03',
    //   },
    //   {
    //     'Judul': 'Air PDAM Tersendat',
    //     'Tujuan': 'Dinas PU',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-02',
    //   },
    //   {
    //     'Judul': 'Trotoar Rusak',
    //     'Tujuan': 'Dinas Perumahan',
    //     'Tanggapan': '(Selesai)',
    //     'Tanggal': '2024-05-30',
    //   },
    //   {
    //     'Judul': 'Kebisingan Malam Hari',
    //     'Tujuan': 'Dinas Lingkungan Hidup',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-04',
    //   },
    //   {
    //     'Judul': 'Parkir Liar',
    //     'Tujuan': 'Dinas Perhubungan',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-05',
    //   },
    //   {
    //     'Judul': 'Pohon Tumbang',
    //     'Tujuan': 'Dinas Kehutanan',
    //     'Tanggapan': '(Selesai)',
    //     'Tanggal': '2024-05-29',
    //   },
    //   {
    //     'Judul': 'Kebocoran Saluran Air',
    //     'Tujuan': 'Dinas PU',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-03',
    //   },
    //   {
    //     'Judul': 'Gangguan Listrik',
    //     'Tujuan': 'Dinas Energi',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-06',
    //   },
    //   {
    //     'Judul': 'Kerusakan Fasilitas Umum',
    //     'Tujuan': 'Dinas Perumahan',
    //     'Tanggapan': '(Selesai)',
    //     'Tanggal': '2024-05-31',
    //   },
    //   {
    //     'Judul': 'Polusi Udara',
    //     'Tujuan': 'Dinas Lingkungan Hidup',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-04',
    //   },
    //   {
    //     'Judul': 'Kebersihan Taman',
    //     'Tujuan': 'Dinas Kebersihan',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-02',
    //   },
    //   {
    //     'Judul': 'Kemacetan Lalu Lintas',
    //     'Tujuan': 'Dinas Perhubungan',
    //     'Tanggapan': '(Selesai)',
    //     'Tanggal': '2024-05-27',
    //   },
    //   {
    //     'Judul': 'Gangguan Air Bersih',
    //     'Tujuan': 'Dinas PU',
    //     'Tanggapan': '(Dalam Proses)',
    //     'Tanggal': '2024-06-05',
    //   },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    const primaryBlue = Color(0xFF1565C0);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
                          Text(
                            'Dinas Komunikasi dan Informatika',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            //sapaan
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Halo, Warga Malang!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface),
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
                              'Jumlah Keluhan',
                              style:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            ),
                            const SizedBox(height: 4),
                            Text('15',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onSurface)),
                          ],
                        )),
                  )),
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
                                'Keluhan Selesai',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '1',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            //Gambar info berita malang
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Image.network(
                'https://malangkab.go.id',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: theme.colorScheme.outline, width: 0.3),
                      )),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('Judul',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface))),
                          Expanded(
                              child: Text('Tujuan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface))),
                          Expanded(
                              child: Text('Tanggapan',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface))),
                          Expanded(
                              child: Text('Tanggal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colorScheme.onSurface))),
                        ],
                      ),
                    ),
                    ...complaints.map(
                      (complaint) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              color: theme.colorScheme.outlineVariant,
                              width: 0.3),
                        )),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              complaint['Judul']!,
                              style:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            )),
                            Expanded(
                                child: Text(
                              complaint['Tujuan']!,
                              style:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            )),
                            Expanded(
                                child: Text(
                              complaint['Tanggapan']!,
                              style: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontSize: 12),
                            )),
                            Expanded(
                                child: Text(
                              complaint['Tanggal']!,
                              style:
                                  TextStyle(color: theme.colorScheme.onSurface),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ]),
        ),
      ),
    );
  }
}
