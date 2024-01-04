import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ews_capstone/screens/loginpage.dart';
import 'package:flutter/material.dart';

// screens import for routes
import 'screens/admin.dart';
import 'screens/detail.dart';
import 'screens/homepage.dart';
import 'screens/mitigasi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'EWS notifications',
          channelDescription: 'Notifikasi EWS Banjir',
        )
      ],
      debug: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff212031),
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.dark(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/detail': (context) => const DetailPage(),
        '/login': (context) => LoginPage(),
        '/admin': (context) => const AdminPage(),
        '/mitigasi': (context) => const MitigasiPage(),
      },
    );
  }
}
