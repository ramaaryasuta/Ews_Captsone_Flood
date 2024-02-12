import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CheckConnectivity extends StatefulWidget {
  const CheckConnectivity({super.key});

  @override
  State<CheckConnectivity> createState() => _CheckConnectivityState();
}

class _CheckConnectivityState extends State<CheckConnectivity> {
  checkConnection() async {
    final connectivityResult =
        await Connectivity().checkConnectivity().then((value) => {
              if (value == ConnectivityResult.none)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tidak dapat terhubung ke internet!'),
                    ),
                  ),
                  setState(() {
                    refreshButton = true;
                  })
                }
              else
                {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false)
                }
            });
    return connectivityResult;
  }

  bool refreshButton = false;

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  void dispose() {
    refreshButton = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Memeriksa Koneksi Internet...",
                style: TextStyle(color: Colors.white),
              ),
              refreshButton
                  ? ElevatedButton(
                      onPressed: () => checkConnection(),
                      child: const Text('Coba Lagi'))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
