import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
    String userId,
    Map<String, dynamic> userInfoMap,
  ) async {
    try {
      await firestore
          .collection("User")
          .doc(userId)
          .set(userInfoMap);

      print("User added successfully to Firestore");
    } on FirebaseException catch (e) {
      print("Firestore Error Code: ${e.code}");
      print("Firestore Error Message: ${e.message}");
      rethrow;
    } catch (e) {
      print("Error adding user: $e");
      rethrow;
    }
  }
}