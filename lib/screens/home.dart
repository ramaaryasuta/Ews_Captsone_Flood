import 'dart:convert';

import 'package:ews_capstone/services/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fl_chart/fl_chart.dart';

// Widgets Component
import 'package:ews_capstone/screens/widgets/home_widget/data_card.dart';
import 'package:ews_capstone/screens/widgets/home_widget/appbar.dart';
import 'package:ews_capstone/screens/widgets/home_widget/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseService dbServ = DatabaseService();

  int rtWaterLevel = 0;
  int rtHumidity = 10;
  int rtTemperature = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dbServ.fApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  CustomScrollView HomePage() {
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
    return CustomScrollView(
      slivers: [
        MyAppbar(
          dbServ: dbServ,
        ),
        ContentSection(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  SliverList ContentSection() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                HeaderContent(
                    rtWaterLevel: rtWaterLevel, rtHumidity: rtHumidity),
                FutureBuilder(
                  future: dbServ.fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Rincian Cuaca :'),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              CardData(
                                icon: LineIcons.thermometerAlt4Full,
                                title: 'Suhu Sekitar',
                                condition: '$rtTemperature°',
                              ),
                              CardData(
                                icon: LineIcons.cloudWithSunAndRain,
                                title: 'Kelembapan Sekitar',
                                condition: '$rtHumidity%',
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text('Grafik tinggi air (cm) :'),
                          const SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 600,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                right: 20,
                                bottom: 10,
                              ),
                              child: LineChart(
                                LineChartData(
                                  minX: 0,
                                  maxX: 24,
                                  minY: 0,
                                  maxY: 100,
                                  titlesData: const FlTitlesData(
                                    show: true,
                                    rightTitles: AxisTitles(),
                                    topTitles: AxisTitles(),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    getDrawingHorizontalLine: (value) {
                                      return const FlLine(
                                        color: Colors.white,
                                        strokeWidth: 0.8,
                                      );
                                    },
                                    drawVerticalLine: false,
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: getChartDataPoint(),
                                      isCurved: true,
                                      belowBarData: BarAreaData(show: true),
                                      dotData: const FlDotData(show: false),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator(
                        color: Colors.amber,
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<FlSpot> getChartDataPoint() {
    List<FlSpot> spots = [];
    for (int i = 0; i <= 48; i++) {
      // position for X
      double x = i / 2;

      // get data waterLevel
      double y = dbServ
          .allData[(((dbServ.allData.length - 1) - 288) + i)].waterLevel
          .toDouble();
      spots.add(FlSpot(x, y));
    }

    return spots;
  }
}
