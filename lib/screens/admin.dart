import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool openSensorMenu = false;
  bool openNotifMenu = false;

  bool actvDHT = false;
  bool actvJSN = false;

  bool relayAlarm = false;

  DatabaseReference rtRef =
      FirebaseDatabase.instance.ref().child('monitor01/admin/');

  @override
  void initState() {
    rtRef.onValue.listen((event) {
      var data = jsonEncode(event.snapshot.value);
      Map<String, dynamic> mapRt = jsonDecode(data);
      relayAlarm = mapRt['relayAlarm'];
      actvDHT = mapRt['dht'];
      actvJSN = mapRt['jsn'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerAdmin(context),
            notifTile(),
            const Divider(),
            if (openNotifMenu) espSection() else const SizedBox(),
            sensorTile(),
            const Divider(),
            if (openSensorMenu) sensorMenu() else const SizedBox(),
            ListTile(
              leading: const Icon(Icons.timeline_sharp),
              title: const Text('Cek Riwayat Pengukuran'),
              subtitle: const Text('Lihat riwayat pengukuran'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () {
                Navigator.pushNamed(context, '/backlog');
              },
            ),
            const Divider(),
          ],
        ),
      ),
    ));
  }

  Container espSection() {
    return Container(
      color: const Color(0xff29273C),
      child: ListTile(
        title: const Text('Relay Alarm'),
        subtitle: relayAlarm
            ? const Text('Relay aktif')
            : const Text('Relay tidak aktif'),
        trailing: Transform.scale(
          scale: 0.7,
          child: Switch(
            value: relayAlarm,
            onChanged: (value) {
              setState(() {
                rtRef.update({'relayAlarm': value});
              });
            },
          ),
        ),
      ),
    );
  }

  ListTile notifTile() {
    return ListTile(
      leading: const Icon(Icons.miscellaneous_services_rounded),
      title: const Text('Akses ESP32'),
      subtitle: const Text('Pengaturan esp32'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        setState(() {
          openNotifMenu = !openNotifMenu;
        });
      },
    );
  }

  ListTile sensorTile() {
    return ListTile(
      leading: const Icon(Icons.sensors_outlined),
      title: const Text('Sensor channel'),
      subtitle: const Text('Akses status sensor'),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () {
        setState(() {
          openSensorMenu = !openSensorMenu;
        });
      },
    );
  }

  Container sensorMenu() {
    return Container(
      color: const Color(0xff29273C),
      child: Column(
        children: [
          ListTile(
            title: const Text('DHT 22 '),
            subtitle: actvDHT
                ? const Text('Sensor Menyala')
                : const Text('Sensor Mati'),
            trailing: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: actvDHT,
                onChanged: (value) {
                  setState(() {
                    rtRef.update({'dht': value});
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('JSN - Ultra Sonic'),
            subtitle: actvJSN
                ? const Text('Sensor Menyala')
                : const Text('Sensor Mati'),
            trailing: Transform.scale(
              scale: 0.7,
              child: Switch(
                  value: actvJSN,
                  onChanged: (value) {
                    setState(() {
                      rtRef.update({'jsn': value});
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Container headerAdmin(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                'Halaman Admin',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout Admin'),
                    content: const Text('Apakah anda yakin ingin keluar ?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (Route route) => false);
                        },
                        child: const Text('Ya'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Tidak'),
                      )
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
    );
  }
}
