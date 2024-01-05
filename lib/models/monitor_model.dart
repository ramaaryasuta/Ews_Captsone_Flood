class MonitorModel {
  String timestamp;
  num humidity;
  num temprature;
  num waterLevel;

  MonitorModel({
    required this.timestamp,
    required this.humidity,
    required this.temprature,
    required this.waterLevel,
  });

  /// map data from db to model
  factory MonitorModel.fromSnapshoot(Map<String, dynamic> document) {
    return MonitorModel(
      timestamp: document['timestamp'],
      humidity: document['humidity'],
      temprature: document['temperature'],
      waterLevel: document['waterlevel'],
    );
  }
}
