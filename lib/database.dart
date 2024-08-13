import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addTask (Map<String, dynamic> userMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Tasks")
        .doc(id)
        .set(userMap);
  }

  Future<Stream<QuerySnapshot>> getTask (String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .snapshots();
  }
}