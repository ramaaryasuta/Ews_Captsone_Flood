import 'package:ews_capstone/screens/widgets/mitigasi/mitigasi_data.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../services/realtime_db.dart';
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
  num rtWaterLevel = 0;
  num rtHumidity = 0;
  num rtTemperature = 0;

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
                Consumer<RealTimeDbService>(builder: (context, value, child) {
                  return GestureDetector(
                    onTap: () {
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
                                        (value.provRtWater > 47)
                                            ? 'Berbahaya'
                                            : (value.provRtWater > 24)
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
                                      langkah: (value.provRtWater > 47)
                                          ? langkahDarurat
                                          : (value.provRtWater > 24)
                                              ? langkahSiaga
                                              : langkahAman,
                                      colors: (value.provRtWater > 47)
                                          ? Colors.red
                                          : (value.provRtWater > 24)
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: (value.provRtWater > 47)
                            ? Colors.red
                            : (value.provRtWater > 24)
                                ? Colors.orange
                                : Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        (value.provRtWater > 47)
                            ? 'Berbahaya - Mitigasi'
                            : (value.provRtWater > 24)
                                ? 'Siaga - Mitigasi'
                                : 'Aman - Mitigasi',
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Consumer<RealTimeDbService>(builder: (context, value, child) {
            return ListDetail(
              suhu: value.provRtTemp,
              humidity: value.provRtHum,
              waterLevel: value.provRtWater,
            );
          }),
          const ChartSec()
        ],
      ),
    );
  }

  Row heroSec() {
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
                      Consumer<RealTimeDbService>(
                        builder: (context, value, child) {
                          return Text(
                            value.provRtWater.toStringAsFixed(2),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'cm',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                Consumer<RealTimeDbService>(
                  builder: (context, value, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kelembapan di sekitar ${value.provRtHum}%',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          (value.provRtHum > 60)
                              ? 'Kemungkinan Hujan'
                              : 'Kemungkinan Cerah',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Consumer<RealTimeDbService>(
            builder: (context, value, child) {
              return Container(
                padding: const EdgeInsets.only(right: 20),
                child: (value.provRtHum > 60)
                    ? SvgPicture.asset(
                        'assets/svg/rainy.svg',
                        width: 150,
                      ) // soon rain svg
                    : SvgPicture.asset(
                        'assets/svg/cloudy.svg',
                        width: 150,
                      ),
              );
            },
          ),
        )
      ],
    );
  }
}
