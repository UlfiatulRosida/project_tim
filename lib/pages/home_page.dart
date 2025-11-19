import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft : Radius.circular(20),
                  bottomRight : Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(image:  AssetImage('assets/logo.png'), height : 40,),
                    
                      SizedBox(width : 10),
                      Column(
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
                      )],
                  )
                ], 
              ),
            )
          ],
        )
      )
    );
  }
}