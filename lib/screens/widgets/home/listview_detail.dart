import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ListDetail extends StatelessWidget {
  const ListDetail({
    super.key,
    required this.suhu,
    required this.humidity,
    required this.waterLevel,
  });

  final num suhu;
  final num humidity;
  final num waterLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keadaan Sekitar',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      LineIcons.water,
                      size: 40,
                    ),
                    const SizedBox(width: 15),
                    const Text('Ketinggian AIr'),
                    const Spacer(),
                    Text('${waterLevel.toStringAsFixed(2)} cm'),
                    const SizedBox(width: 5),
                  ],
                ),
                const Divider(color: Colors.grey)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      LineIcons.thermometerEmpty,
                      size: 40,
                    ),
                    const SizedBox(width: 15),
                    const Text('Suhu Sekitar'),
                    const Spacer(),
                    Text('$suhu°C'),
                    const SizedBox(width: 5),
                  ],
                ),
                const Divider(color: Colors.grey)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      LineIcons.cloudWithSunAndRain,
                      size: 40,
                    ),
                    const SizedBox(width: 15),
                    const Text('Kelembapan'),
                    const Spacer(),
                    Text('$humidity%'),
                    const SizedBox(width: 5),
                  ],
                ),
                const Divider(color: Colors.grey)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
