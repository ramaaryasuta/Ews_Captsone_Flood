import 'package:flutter/material.dart';

import '../services/database.dart';
import 'widgets/login/login_content.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final DatabaseService dbServ = DatabaseService();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212031),
        title: const Text('Admin'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: dbServ.admindata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoginContent(
              userCtrl: userCtrl,
              passCtrl: passCtrl,
              listAdmin: snapshot.data,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
