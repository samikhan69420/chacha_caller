import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHandler {
  Future<void> addUserToDatabase(Map<String, dynamic> data) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String id = firestore.collection('users').doc().id;
    firestore.collection('users').doc(id).set(data);
  }
}
