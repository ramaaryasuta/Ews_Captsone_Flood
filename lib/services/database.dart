import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ews_capstone/models/admin_model.dart';
import 'package:ews_capstone/models/monitor_model.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

class DatabaseService {
  List<MonitorModel> allData = [];
  List<AdminModel> account = [];

  final Future<FirebaseApp> fApp = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Fetch All data From Firestore Database
  Future fetchData() async {
    CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore
        .instance
        .collection('EarlyWarningSystems/monitors/monitor01');

    try {
      // Fetch data from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await collection.get();
      print('Dapat data');

      // get data object to list
      final berhasil = querySnapshot.docs.map((e) {
        print(e['humidity']);
        return MonitorModel.fromSnapshoot(e);
      }).toList();
      print('Berhasil save');
      print(berhasil.length);

      // testing read data
      // for (int i = 0; i < response.length; i++) {
      //   allData.add(MonitorModel(
      //     timestamp: response[i].timestamp,
      //     humidity: response[i].humidity,
      //     temprature: response[i].temprature,
      //     waterLevel: response[i].waterLevel,
      //   ));
      // }
      return allData;
    } catch (e) {
      return e;
    }
  }

  /// Fetch account for admin
  Future admindata() async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('Accounts');

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection.get();
    final response =
        querySnapshot.docs.map((doc) => AdminModel.fromSnapshoot(doc)).toList();
    for (int i = 0; i < response.length; i++) {
      account.add(
        AdminModel(
          username: response[i].username,
          password: response[i].password,
        ),
      );
    }
    return account;
  }
}
