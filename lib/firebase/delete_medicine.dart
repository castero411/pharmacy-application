import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteMedicine(String medicineName) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final String uid = user.uid;

    // Reference the user's document in Firestore
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    await userDocRef.update({
      'medicines.$medicineName': FieldValue.delete(),
    });
  } catch (e) {
    print(e);
  }
}

Future<void> deleteDate(String medicineName, String date) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final String uid = user.uid;

    // Reference the user's document in Firestore
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    try {
      await userDocRef.update({
        'medicines.$medicineName.takenDate.$date': FieldValue.delete(),
      });
    } catch (e) {
      print(e);
    }
  } catch (e) {
    print(e);
  }
}
