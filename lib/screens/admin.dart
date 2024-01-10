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

  bool isActive = false;

  TextEditingController bannerTextCtrl = TextEditingController();

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
            if (openNotifMenu) bannerTxtField() else const SizedBox(),
            sensorTile(),
            const Divider(),
            if (openSensorMenu) sensorMenu() else const SizedBox(),
          ],
        ),
      ),
    ));
  }

  Container bannerTxtField() {
    final DatabaseReference rtRef =
        FirebaseDatabase.instance.ref().child('monitor01/admin/isActive');
    rtRef.onValue.listen((event) {
      setState(() {
        isActive = event.snapshot.value as bool;
      });
    });
    return Container(
      color: const Color(0xff29273C),
      child: ListTile(
        title: const Text('Mode Aktif'),
        trailing: Transform.scale(
          scale: 0.7,
          child: Switch(
            value: isActive,
            onChanged: (value) {
              if (value) {
                rtRef.set(true);
              } else {
                rtRef.set(false);
              }
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
    DatabaseReference rtRef =
        FirebaseDatabase.instance.ref().child('monitor01/admin/');
    rtRef.onValue.listen((event) {
      var data = jsonEncode(event.snapshot.value);
      Map<String, dynamic> mapRt = jsonDecode(data);
      setState(() {
        actvDHT = mapRt['dht'];
        actvJSN = mapRt['jsn'];
      });
    });
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
                  if (value) {
                    rtRef.update({'dht': value});
                  } else {
                    rtRef.update({'dht': value});
                  }
                  setState(() {
                    actvDHT = value;
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
                    if (value) {
                      rtRef.update({'jsn': value});
                    } else {
                      rtRef.update({'jsn': value});
                    }
                    setState(() {
                      actvJSN = value;
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
          const Text(
            'Halaman Admin',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah anda yakin ingin keluar?'),
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
