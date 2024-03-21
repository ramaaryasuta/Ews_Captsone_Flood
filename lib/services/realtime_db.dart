import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealTimeDbService with ChangeNotifier {
  num provRtWater = 0;
  num provRtTemp = 0;
  num provRtHum = 0;

  DatabaseReference refRealtime =
      FirebaseDatabase.instance.ref().child('monitor01/monitors/');

  RealTimeDbService() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      getRtDb();
    });
  }

  void getRtDb() {
    refRealtime.onValue.listen((event) {
      var data = jsonEncode(event.snapshot.value);
      Map<String, dynamic> mapRt = jsonDecode(data);
      provRtWater = mapRt['waterlevel'];
      provRtTemp = mapRt['temperature'];
      provRtHum = mapRt['humidity'];
      notifyListeners();
    });
  }
}
