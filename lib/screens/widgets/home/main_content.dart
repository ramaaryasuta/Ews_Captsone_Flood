import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ews_capstone/screens/widgets/mitigasi/mitigasi_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chart_content.dart';
import 'listview_detail.dart';
import '../mitigasi/list_mitigasi_builder.dart';

class MainContent extends StatefulWidget {
  const MainContent({
    super.key,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  /// default value
  int rtWaterLevel = 0;
  double rtHumidity = 0;
  double rtTemperature = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          heroSec(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xff29273C),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Text('Status :'),
                const SizedBox(width: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: (rtWaterLevel > 47)
                        ? Colors.red
                        : (rtWaterLevel > 24)
                            ? Colors.orange
                            : Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    (rtWaterLevel > 47)
                        ? 'Berbahaya'
                        : (rtWaterLevel > 24)
                            ? 'Siaga'
                            : 'Aman',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(),
                                    Text(
                                      (rtWaterLevel > 47)
                                          ? 'Berbahaya'
                                          : (rtWaterLevel > 24)
                                              ? 'Siaga'
                                              : 'Aman',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListMitigasi(
                                    langkah: (rtWaterLevel > 47)
                                        ? langkahDarurat
                                        : (rtWaterLevel > 24)
                                            ? langkahSiaga
                                            : langkahAman,
                                    colors: (rtWaterLevel > 47)
                                        ? Colors.red
                                        : (rtWaterLevel > 24)
                                            ? Colors.orange
                                            : Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Mitigasi'),
                )
              ],
            ),
          ),
          ListDetail(
            suhu: rtTemperature,
            humidity: rtHumidity,
            waterLevel: rtWaterLevel,
          ),
          const ChartSec()
        ],
      ),
    );
  }

  Row heroSec() {
    DatabaseReference refRealtime =
        FirebaseDatabase.instance.ref().child('monitor01/monitors/');
    // listen to firebase realtime database value
    refRealtime.onValue.listen(
      (event) {
        var data = jsonEncode(event.snapshot.value);
        Map<String, dynamic> mapRt = jsonDecode(data);
        setState(() {
          rtWaterLevel = mapRt['waterlevel'];
          rtHumidity = mapRt['humidity'];
          rtTemperature = mapRt['temperature'];
        });
      },
    );

    // if (rtWaterLevel > 24) {
    //   NotificationFunc('Siaga', 'Ketinggian air sudah diatas 24 cm');
    // }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ketinggian Air',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        '$rtWaterLevel',
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'cm',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('Dari Permukaan Tanah'),
                Text(
                  'Kelembaban disekitar $rtHumidity%',
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  (rtHumidity > 60) ? 'Kemungkinan Hujan' : 'Kemungkinan Cerah',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.only(right: 20),
            child: (rtHumidity > 60)
                ? SvgPicture.asset(
                    'assets/svg/rainy.svg',
                    width: 150,
                  ) // soon rain svg
                : SvgPicture.asset(
                    'assets/svg/cloudy.svg',
                    width: 150,
                  ),
          ),
        )
      ],
    );
  }

  notificationFunc(String title, String body) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
