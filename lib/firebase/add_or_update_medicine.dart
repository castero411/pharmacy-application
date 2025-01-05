import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_manager/models/medicine.dart';

Future<void> addOrUpdateMedicine(Medicine medicine) async {
  try {
    // Get the current user's UID
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final String uid = user.uid;

    // Reference the user's document in Firestore
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Add or update the medicine under the 'medicines' map
    await userDocRef.set(
      {
        'medicines': {
          medicine.name: medicine.toMap(),
        },
      },
      SetOptions(merge: true), // Merge ensures existing data isn't overwritten
    );
  } catch (e) {
    print("Error adding or updating medicine in Firestore: $e");
  }
}
