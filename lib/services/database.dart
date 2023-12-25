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

      // get data object to list
      final response = querySnapshot.docs
          .map((doc) => MonitorModel.fromSnapshoot(doc))
          .toList();

      // testing read data
      for (int i = 0; i < response.length; i++) {
        allData.add(MonitorModel(
          timestamp: response[i].timestamp,
          humidity: response[i].humidity,
          temprature: response[i].temprature,
          waterLevel: response[i].waterLevel,
        ));
      }
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

  void getDocumentId() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('EarlyWarningSystems/monitors/monitor01');

    // Query the collection, for example, get the first document
    QuerySnapshot querySnapshot = await collectionReference.get();

    // Check if there are documents in the query result
    if (querySnapshot.docs.isNotEmpty) {
      // Get the document ID of the first document
      // String documentId = querySnapshot.docs[0].id;

      // print("Document ID: $documentId");

      for (int i = 0; i < 2; i++) {
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('EarlyWarningSystems/monitors/monitor01')
            .doc(querySnapshot.docs[i].id.toString());

        documentReference.delete().then((value) {
          print("Document successfully deleted!");
          print(querySnapshot.docs[i].id.toString());
        }).catchError((error) => print("Error deleting document: $error"));
      }
    } else {
      print("No documents found in the collection");
    }
  }

  // nyoba
  void deleteDataAuto() async {
    int currentEpoch = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    int deleteInMonth = 1 * 30 * 24 * 60 * 60;
    int dateToDelete = currentEpoch - deleteInMonth;
    List<int> allData = [1, 2, 3, 4, 5, 6, 7];

    List<int> filterData = allData.where((number) => number < 5).toList();
    print(filterData);
  }
}
