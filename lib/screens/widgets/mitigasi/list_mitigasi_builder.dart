import 'package:flutter/material.dart';

class ListMitigasi extends StatelessWidget {
  const ListMitigasi({
    super.key,
    required this.langkah,
    required this.colors,
  });

  final List langkah;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: langkah.length,
      itemBuilder: (context, index) {
        final int indexs = index + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$indexs. ${langkah[index]['title']}: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colors,
                  ),
                ),
                TextSpan(
                  text: langkah[index]['desc'],
                  style: const TextStyle(height: 1.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
