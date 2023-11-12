import 'package:flutter/material.dart';

class HeaderContent extends StatelessWidget {
  const HeaderContent({
    super.key,
    required this.rtWaterLevel,
    required this.rtHumidity,
  });

  final int rtWaterLevel;
  final int rtHumidity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              flex: 2,
              child: Text(
                rtWaterLevel.toString(),
                style: const TextStyle(
                  fontSize: 56,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: const Text(
                  'Cm tinggi air dari daratan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Text('Kelembapan Sekitar : '),
            const SizedBox(width: 5),
            Text(rtHumidity.toString() + ' %'),
            const SizedBox(width: 5),
            rtHumidity > 70 ? Text('Kemungkinan Hujan') : Text('Cerah')
          ],
        ),
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blom tau mau dikasih informasi apa disini'),
              Text('Berita mungkin, atau notifikasi'),
            ],
          ),
        ),
      ],
    );
  }
}
