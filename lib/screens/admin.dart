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

  TextEditingController bannerTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            headerAdmin(context),
            sensorTile(),
            const Divider(),
            if (openSensorMenu) sensorMenu() else const SizedBox(),
            notifTile(),
            const Divider(),
            if (openNotifMenu) bannerTxtField() else const SizedBox(),
          ],
        ),
      ),
    ));
  }

  Container bannerTxtField() {
    DatabaseReference rtRef =
        FirebaseDatabase.instance.ref().child('monitor01/admin/');
    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            controller: bannerTextCtrl,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              hintText: 'Enter your text',
              border: const OutlineInputBorder(),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
            onPressed: () {
              rtRef.update({'notif': bannerTextCtrl.text.toString()});
            },
            child: const Text('Update Banner'),
          )
        ],
      ),
    );
  }

  ListTile notifTile() {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: const Text('Banner Notifikasi'),
      subtitle: const Text('update banner notifikasi'),
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
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          ListTile(
            title: const Text('DHT 22 '),
            subtitle: Text('Aktif : $actvDHT'),
            trailing: Switch(
                value: actvDHT,
                onChanged: (value) {
                  if (value) {
                    rtRef.update({'dht': 'Aktif'});
                  } else {
                    rtRef.update({'dht': 'Perbaikan'});
                  }
                  setState(() {
                    actvDHT = value;
                  });
                }),
          ),
          ListTile(
            title: const Text('JSN - Ultra Sonic'),
            subtitle: Text('Aktif : $actvJSN'),
            trailing: Switch(
                value: actvJSN,
                onChanged: (value) {
                  if (value) {
                    rtRef.update({'jsn': 'Aktif'});
                  } else {
                    rtRef.update({'jsn': 'Perbaikan'});
                  }
                  setState(() {
                    actvJSN = value;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Container headerAdmin(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
            radius: 30,
          ),
          const Text(
            'Hello Admin',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/', (Route route) => false);
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
    );
  }
}
