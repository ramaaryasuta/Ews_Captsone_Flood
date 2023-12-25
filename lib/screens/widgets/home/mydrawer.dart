import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff212031),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: ListTile(
                onTap: () {},
                leading: const Icon(LineIcons.user),
                title: const Text('Administrator'),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
