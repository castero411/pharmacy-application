import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> editNewUsername(String userId, String newUsername) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.doc(userId).update({'username': newUsername});
  } catch (e) {
    print("failed to update username");
  }
}
