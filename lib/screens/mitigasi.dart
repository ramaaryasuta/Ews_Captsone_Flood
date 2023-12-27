import 'package:ews_capstone/screens/widgets/mitigasi/mitigasi_data.dart';
import 'package:flutter/material.dart';

import 'widgets/mitigasi/list_mitigasi_builder.dart';

class MitigasiPage extends StatelessWidget {
  const MitigasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff212031),
          title: const Text('Pelajari Mitigasi Banjir'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Mitigasi bencana alam adalah serangkaian tindakan yang dirancang untuk mengurangi dampak buruk dari bencana alam yang mungkin terjadi. Tujuan utamanya adalah untuk melindungi manusia, harta benda, lingkungan, dan infrastruktur dari kerusakan yang bisa disebabkan oleh bencana alam seperti gempa bumi, banjir, badai, kebakaran hutan, tsunami, dan lain sebagainya. \n Mitigasi bencana alam sangat penting untuk mengurangi kerugian yang disebabkan oleh bencana dan untuk mempersiapkan masyarakat agar lebih tangguh menghadapi ancaman bencana di masa depan.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(height: 1.5),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Langkah - langkah mitigasi banjir'),
              const TabBar(
                tabs: [
                  Tab(text: 'Aman'),
                  Tab(text: 'Siaga'),
                  Tab(text: 'Bahaya'),
                ],
              ),
              Container(
                width: double.infinity,
                height: 400,
                padding: const EdgeInsets.all(20),
                child: TabBarView(
                  children: [
                    ListMitigasi(
                      langkah: langkahAman,
                      colors: Colors.green,
                    ),
                    ListMitigasi(
                      langkah: langkahSiaga,
                      colors: Colors.amber,
                    ),
                    ListMitigasi(
                      langkah: langkahDarurat,
                      colors: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
