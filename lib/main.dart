import 'package:ews_capstone/screens/login.dart';
import 'package:ews_capstone/screens/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // Create routes for another Page
        '/': (context) => const HomeScreen(),
        '/admin': (context) => const LoginPage(),
      },
    );
  }
}
