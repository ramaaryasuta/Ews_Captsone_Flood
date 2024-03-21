import 'package:ews_capstone/screens/loginpage.dart';
import 'package:ews_capstone/checking_connectivity.dart';
import 'package:ews_capstone/services/realtime_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// screens import for routes
import 'firebase_options.dart';
import 'screens/admin.dart';
import 'screens/backlog.dart';
import 'screens/homepage.dart';
import 'screens/mitigasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => RealTimeDbService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff212031),
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.dark(
          primary: Colors.blueAccent.shade200,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/check-connection',
      routes: {
        '/check-connection': (context) => const CheckConnectivity(),
        '/': (context) => const HomePage(),
        '/backlog': (context) => BacklogPage(),
        '/login': (context) => LoginPage(),
        '/admin': (context) => const AdminPage(),
        '/mitigasi': (context) => const MitigasiPage(),
      },
    );
  }
}
