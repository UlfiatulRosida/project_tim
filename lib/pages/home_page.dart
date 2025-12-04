import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final complaints = [
    {
      'Judul': 'Jalan Berlubang',
      'Tujuan': 'Dinas Tenaga Kerja',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-01',
    },
    {
      'Judul': 'Lampu Jalan Mati',
      'Tujuan': 'Dinas Perhubungan',
      'Tanggapan': '(Selesai)',
      'Tanggal': '2024-05-28',
    },
    {
      'Judul': 'Sampah Menumpuk',
      'Tujuan': 'Dinas Kebersihan',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-03',
    },
    {
      'Judul': 'Air PDAM Tersendat',
      'Tujuan': 'Dinas PU',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-02',
    },
    {
      'Judul': 'Trotoar Rusak',
      'Tujuan': 'Dinas Perumahan',
      'Tanggapan': '(Selesai)',
      'Tanggal': '2024-05-30',
    },
    {
      'Judul': 'Kebisingan Malam Hari',
      'Tujuan': 'Dinas Lingkungan Hidup',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-04',
    },
    {
      'Judul': 'Parkir Liar',
      'Tujuan': 'Dinas Perhubungan',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-05',
    },
    {
      'Judul': 'Pohon Tumbang',
      'Tujuan': 'Dinas Kehutanan',
      'Tanggapan': '(Selesai)',
      'Tanggal': '2024-05-29',
    },
    {
      'Judul': 'Kebocoran Saluran Air',
      'Tujuan': 'Dinas PU',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-03',
    },
    {
      'Judul': 'Gangguan Listrik',
      'Tujuan': 'Dinas Energi',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-06',
    },
    {
      'Judul': 'Kerusakan Fasilitas Umum',
      'Tujuan': 'Dinas Perumahan',
      'Tanggapan': '(Selesai)',
      'Tanggal': '2024-05-31',
    },
    {
      'Judul': 'Polusi Udara',
      'Tujuan': 'Dinas Lingkungan Hidup',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-04',
    },
    {
      'Judul': 'Kebersihan Taman',
      'Tujuan': 'Dinas Kebersihan',
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-02',
    },
    {
      'Judul': 'Kemacetan Lalu Lintas',
      'Tujuan': 'Dinas Perhubungan',
      'Tanggapan': '(Selesai)',
      'Tanggal': '2024-05-27',
    },
    {
      'Judul': 'Gangguan Air Bersih',
      'Tujuan': 'Dinas PU',   
      'Tanggapan': '(Dalam Proses)',
      'Tanggal': '2024-06-05',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header 
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0),
                borderRadius: BorderRadius.only(
                  bottomLeft : Radius.circular(20),
                  bottomRight : Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/9/9f/Lambang_Kota_Malang.png',
                        width : 50,
                        height : 50,
                      ),
                       const SizedBox(width : 10),
                       const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Surat Warga',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Dinas Komunikasi dan Informatika',
                            style: TextStyle(
                              color: Colors.white70,
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Halo, Warga Malang!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Statistik Keluhan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child:Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: const Padding(
                        padding:EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.mail_outline, color: Color(0xFF1565C0)),
                            SizedBox(height : 8),
                            Text('Jumlah Keluhan'),
                            SizedBox(height : 4),
                            Text('15', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                          ],
                        )
                      ),
                    )
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Icon(Icons.check_circle_outline, color: Color(0xFF1565C0)),
                            SizedBox(height : 8),
                            Text('Keluhan Selesai'),
                            SizedBox(height : 4),
                            Text('1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Gambar info berita malang
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Image.network(
                'https://malangkota.go.id/wp-content/uploads/2020/06/berita-malang.jpg',
                height : 180,
                width : double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Daftar Pengaduan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
              color: Colors.white,
              elevation: 3,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom : BorderSide(color: Colors.grey, width : 0.3),
                        )
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text('Judul',
                              style: TextStyle(
                                fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Text('Tujuan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Text('Tanggapan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold))),
                          Expanded(
                            child: Text('Tanggal',
                            style: TextStyle(
                              fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    ...complaints.map((complaint) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom : BorderSide(color: Colors.grey, width : 0.3),
                        )
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(complaint['Judul']!)),
                          Expanded(child: Text(complaint['Tujuan']!)),
                          Expanded(child: Text(complaint['Tanggapan']!, style: const TextStyle(color: Colors.grey, fontSize: 12),)),
                          Expanded(child: Text(complaint['Tanggal']!)),
                        ],
                      ),
                    ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height : 80),
          ]
        ),  
      ),
    ),);
  }
}