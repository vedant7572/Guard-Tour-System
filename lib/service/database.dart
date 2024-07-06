import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(Id)
        .set(userInfoMap);
  }

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    return snapshot.data() as Map<String, dynamic>;
}
