import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BacklogPage extends StatelessWidget {
  BacklogPage({super.key});
  final CollectionReference dataCol = FirebaseFirestore.instance
      .collection('EarlyWarningSystems/monitors/monitor01');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pengukuran'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: dataCol.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.separated(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final QueryDocumentSnapshot data =
                  documents[documents.length - 1 - index];
              // Gunakan data dari dokumen di sini
              return ListTile(
                title: Text(data['timestamp'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tinggi air: ${data['waterlevel']} cm',
                    ),
                    Text(
                      'Suhu: ${data['temperature']} °C',
                    ),
                    Text(
                      'Kelembaban: ${data['humidity']} %',
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
