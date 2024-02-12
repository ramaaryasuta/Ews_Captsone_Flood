import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ews_capstone/models/monitor_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartSec extends StatefulWidget {
  const ChartSec({
    super.key,
  });

  @override
  State<ChartSec> createState() => _ChartSecState();
}

class _ChartSecState extends State<ChartSec> {
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  final CollectionReference collection = FirebaseFirestore.instance
      .collection('EarlyWarningSystems/monitors/monitor01');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error: Terjadi kesalahan');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Memuat Chart...'),
              ],
            ),
          );
        }

        /// Getting data from firestore
        final List<Map<String, dynamic>> documents = snapshot.data!.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        final List<MonitorModel> data = documents.map((doc) {
          return MonitorModel.fromSnapshoot(doc);
        }).toList();

        int lastData = data.length - 1;

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Icon(
                    Icons.ssid_chart_rounded,
                    size: 30,
                  ),
                  SizedBox(width: 20),
                  Text('Grafik pemantauan tinggi air'),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 1.5,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 10,
                    verticalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: leftTitleWidgets,
                        reservedSize: 42,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            fontSize: 12,
                          );
                          Widget text;
                          switch (value.toInt()) {
                            case 1:
                              text = Text(
                                  extractTime(data[lastData - 17].timestamp),
                                  style: style);
                              break;
                            case 5:
                              text = Text(
                                  extractTime(data[lastData - 13].timestamp),
                                  style: style);
                              break;
                            case 9:
                              text = Text(
                                  extractTime(data[lastData - 9].timestamp),
                                  style: style);
                              break;
                            case 13:
                              text = Text(
                                  extractTime(data[lastData - 5].timestamp),
                                  style: style);
                              break;
                            case 17:
                              text = Text(
                                  extractTime(data[lastData - 1].timestamp),
                                  style: style);
                              break;
                            default:
                              text = const Text('', style: style);
                              break;
                          }

                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: text,
                          );
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: Colors.blueAccent.withOpacity(0.4)),
                  ),
                  minX: 0,
                  maxX: 18,
                  minY: 0,
                  maxY: 120,
                  lineBarsData: [
                    LineChartBarData(
                      spots: getChartDataPoint(data),
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: gradientColors,
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: gradientColors
                              .map((color) => color.withOpacity(0.3))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipMargin: 50,
                      fitInsideHorizontally: true,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          TextStyle textStyle = const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          );
                          return LineTooltipItem(
                            "${barSpot.y.toInt()} cm\n ${data[(data.length - 19) + barSpot.x.toInt()].timestamp}",
                            textStyle,
                          );
                        }).toList();
                      },
                    ),
                  ),
                )),
              ),
            )
          ],
        );
      },
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 20:
        text = '20 cm';
        break;
      case 40:
        text = '40 cm';
        break;
      case 60:
        text = '60 cm';
        break;
      case 80:
        text = '80 cm';
        break;
      case 100:
        text = '100 cm';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> getChartDataPoint(List<MonitorModel> data) {
    List<FlSpot> spots = [];
    for (int i = 0; i < 19; i++) {
      // position for X
      double x = i.toDouble();

      // get data waterLevel
      double y = data[data.length - 19 + i].waterLevel.toDouble();
      spots.add(FlSpot(x, y));
    }

    return spots;
  }

  String extractTime(String input) {
    // Split the input string by space
    List<String> parts = input.split(' ');

    // Find the time part
    String timePart = parts.last;

    return timePart;
  }
}
