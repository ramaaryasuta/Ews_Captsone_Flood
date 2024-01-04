import 'package:awesome_notifications/awesome_notifications.dart';
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
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllow) => {
          if (!isAllow)
            {AwesomeNotifications().requestPermissionToSendNotifications()}
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff212031),
        title: const Text('Semarang Selatan'),
        actions: [
          IconButton(
            onPressed: () {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 10,
                  channelKey: 'basic_channel',
                  title: 'EWS Banjir 29',
                  body: 'Sample Notification',
                ),
              );
            },
            icon: const Icon(Icons.notification_add),
          )
        ],
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
