import 'package:cloud_firestore/cloud_firestore.dart';

class MonitorModel {
  String timestamp;
  int humidity;
  int temprature;
  int waterLevel;

  MonitorModel({
    required this.timestamp,
    required this.humidity,
    required this.temprature,
    required this.waterLevel,
  });

  // map data from db to model
  factory MonitorModel.fromSnapshoot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    return MonitorModel(
      timestamp: document['timestamp'],
      humidity: document['humidity'],
      temprature: document['temperature'],
      waterLevel: document['waterlevel'],
    );
  }
}
