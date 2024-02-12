import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({
    super.key,
  });

  final Uri _url = Uri.parse("https://bit.ly/FeedbackEwsApp29");

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff212031),
      child: SafeArea(
        child: Column(
          children: [
            DrawerTile(
              icon: LineIcons.user,
              title: 'Administrator',
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
            DrawerTile(
              icon: LineIcons.bookOpen,
              title: 'Pelajari Mitigasi',
              onTap: () {
                Navigator.pushNamed(context, '/mitigasi');
              },
            ),
            DrawerTile(
              icon: LineIcons.clock,
              title: 'Riwayat',
              onTap: () {
                Navigator.pushNamed(context, '/backlog');
              },
            ),
            DrawerTile(
              icon: LineIcons.commentDots,
              title: 'Berikan Umpan Balik',
              onTap: () => _launchUrl(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: ListTile(
        onTap: () {
          onTap();
        },
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
      ),
    );
  }
}
