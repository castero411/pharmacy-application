import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> createEmptyUserDocument({
  required String username,
  required String email,
}) async {
  try {
    // Get the current user's UID
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final String uid = user.uid;

    // Reference the user's document in Firestore
    final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Create an empty document
    await docRef.set({
      'uid': uid,
      'username': username,
      'email': email,
    });
  } catch (e) {
    print("Error creating empty document in Firestore: $e");
  }
}
