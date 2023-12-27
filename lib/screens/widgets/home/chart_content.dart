import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../services/database.dart';

class ChartSec extends StatefulWidget {
  const ChartSec({
    super.key,
  });

  @override
  State<ChartSec> createState() => _ChartSecState();
}

class _ChartSecState extends State<ChartSec> {
  final DatabaseService dbServ = DatabaseService();

  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  void initState() {
    dbServ.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbServ.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              const Text('Grafik pemantauan tinggi air'),
              AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: 24,
                    bottom: 12,
                  ),
                  child: LineChart(mainData()),
                ),
              )
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    String timeStamp(int index) {
      String dateTimeString = dbServ.allData[index].timestamp;

      List<String> parts = dateTimeString.split(' ');

      String timePart = parts[0];

      List<String> timeParts = timePart.split(':');

      String timeWithoutSeconds = "${timeParts[0]}:${timeParts[1]}";

      return timeWithoutSeconds;
    }

    final int dbLength = dbServ.allData.length;

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(timeStamp(dbLength - 19), style: style);
        break;
      case 3:
        text = Text(timeStamp(dbLength - 16), style: style);
        break;
      case 6:
        text = Text(timeStamp(dbLength - 13), style: style);
        break;
      case 9:
        text = Text(timeStamp(dbLength - 10), style: style);
        break;
      case 12:
        text = Text(timeStamp(dbLength - 7), style: style);
        break;
      case 15:
        text = Text(timeStamp(dbLength - 4), style: style);
        break;
      case 18:
        text = Text(timeStamp(dbLength - 1), style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
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
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
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
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 17,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: getChartDataPoint(),
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
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              TextStyle textStyle = const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              );
              return LineTooltipItem(
                "${barSpot.y.toInt()} cm\n ${dbServ.allData[(dbServ.allData.length - 18) + barSpot.x.toInt()].timestamp}",
                textStyle,
              );
            }).toList();
          },
        ),
      ),
    );
  }

  List<FlSpot> getChartDataPoint() {
    List<FlSpot> spots = [];
    for (int i = 0; i < 18; i++) {
      // position for X
      double x = i.toDouble();

      // get data waterLevel
      double y = dbServ.allData[((dbServ.allData.length - 18) + i)].waterLevel
          .toDouble();
      spots.add(FlSpot(x, y));
    }

    return spots;
  }
}
