import 'package:ews_capstone/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAppbar extends StatelessWidget {
  MyAppbar({super.key, required this.dbServ});

  DatabaseService dbServ;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[850],
      floating: true,
      pinned: true,
      elevation: 5,
      expandedHeight: 100,
      flexibleSpace: const FlexibleSpaceBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Semarang Selatan'),
            SizedBox(height: 3),
            Text(
              'Semarang, Jawa Tengah',
              style: TextStyle(fontSize: 8),
            ),
          ],
        ),
        titlePadding: EdgeInsets.all(15),
      ),
      actions: [
        PopupMenuButton(
          onSelected: (item) => onSelect(context, item),
          offset: const Offset(0, 55),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 0,
              child: Text('Admin'),
            ),
            const PopupMenuItem(
              value: 1,
              child: Text('About'),
            ),
            const PopupMenuItem(
              value: 2,
              child: Text('Get Id'),
            ),
            const PopupMenuItem(
              value: 3,
              child: Text('Epoch'),
            ),
          ],
        )
      ],
    );
  }

  void onSelect(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, '/admin');
        break;
      case 2:
        // dbServ.getDocumentId();
        break;
      case 3:
        // dbServ.deleteDataAuto();
        break;
    }
  }
}
