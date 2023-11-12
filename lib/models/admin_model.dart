import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String username;
  String password;

  AdminModel({required this.username, required this.password});

  // map data from db to model
  factory AdminModel.fromSnapshoot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    return AdminModel(
      username: document['username'],
      password: document['password'],
    );
  }
}
