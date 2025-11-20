import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final complaints = [
    {
      'judul': 'Jalan Berlubang',
      'tujuan': 'Dinas Tenaga Kerja',
      'status': 'Dalam Proses',
      'tanggal': '2024-06-01',
    },
    {
      'judul': 'Lampu Jalan Mati',
      'tujuan': 'Dinas Perhubungan',
      'status': 'Selesai',
      'tanggal': '2024-05-28',
    },
    {
      'judul': 'Sampah Menumpuk',
      'tujuan': 'Dinas Kebersihan',
      'status': 'Dalam Proses',
      'tanggal': '2024-06-03',
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
                color: Colors.blue,
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
            // Daftar Pengaduan
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
                            Text('3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
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
          ]
        ),  
      ),
    ),
    );
  }
}