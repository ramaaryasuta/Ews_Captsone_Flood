import 'dart:convert';

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
  int rtHumidity = 0;
  int rtTemperature = 0;

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
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Aman'),
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
                                    const Text(
                                      'Kondisi Aman',
                                      style: TextStyle(fontSize: 20),
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
                                    langkah: langkahAman,
                                    colors: Colors.green,
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
          ChartSec()
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
}
