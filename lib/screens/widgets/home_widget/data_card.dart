import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

// ignore: must_be_immutable
class CardData extends StatelessWidget {
  CardData({
    super.key,
    required this.icon,
    required this.title,
    required this.condition,
  });

  IconData icon;
  String title;
  String condition;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100,
        height: 220,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.black45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            LineIcon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              condition,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(5),
                width: double.infinity,
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Colors.white,
                  ),
                )),
                child: const Center(child: Text('Detail')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
