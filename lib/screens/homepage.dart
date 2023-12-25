import 'package:flutter/material.dart';

import '../services/database.dart';
import 'widgets/home/main_content.dart';
import 'widgets/home/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService dbServ = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212031),
        title: const Text('Semarang Selatan'),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: dbServ.fApp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainContent();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
