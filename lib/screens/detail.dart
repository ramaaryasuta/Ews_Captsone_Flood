import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  final CollectionReference dataCol = FirebaseFirestore.instance
      .collection('EarlyWarningSystems/monitors/monitor01');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Firestore'),
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
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final QueryDocumentSnapshot data = documents[index];
              // Gunakan data dari dokumen di sini
              return ListTile(
                title: Text(data['humidity'].toString()),
                subtitle: Text(data['timestamp'].toString()),
              );
            },
          );
        },
      ),
    );
  }
}
