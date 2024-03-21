import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'widgets/home/main_content.dart';
import 'widgets/home/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final String topic = "new_user_forums";

  bool getNotif = false;

  @override
  void initState() {
    super.initState();

    /// when app foreground
    FirebaseMessaging.onMessage.listen((message) {
      FirebaseMessaging.onMessage.listen((message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null && getNotif == false) {
          getNotif = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(notification.title ?? ''),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [Text(notification.body ?? '')],
                  ),
                ),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      getNotif = false;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  }

  @override
  Widget build(BuildContext context) {
    firebaseMessaging.subscribeToTopic(topic);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 53, 51, 79),
        title: const Text('Semarang Utara'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.cyan.withOpacity(0.6),
                      content: const Text(
                        'Memuat ulang...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                });
              },
              icon: const Icon(Icons.refresh_rounded))
        ],
      ),
      drawer: MyDrawer(),
      body: const MainContent(),
    );
  }
}
