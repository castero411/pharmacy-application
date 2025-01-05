import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_manager/models/medicine.dart';

Future<List<Medicine>> getMedicines() async {
  try {
    // Get the current user's UID
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final String uid = user.uid;

    // Reference the user's document in Firestore
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(uid);

    // Get the medicines map from the user's document
    final snapshot = await userDocRef.get();

    if (!snapshot.exists || snapshot.data() == null) {
      return []; // Return an empty list if no data exists
    }

    final medicinesMap = snapshot.data()!['medicines'] as Map<String, dynamic>?;

    if (medicinesMap == null) {
      return []; // Return an empty list if the medicines map is null
    }

    // Convert the medicines map to a list of Medicine objects
    final medicines = medicinesMap.entries.map((entry) {
      return Medicine(
        name: entry.key,
        description: entry.value['description'] ?? '',
        type: entry.value['type'] ?? '',
        dose: entry.value['dose'] ?? '',
        doseCount: entry.value['doseCount'] ?? '',
        startingDate: (entry.value['startingDate'] as Timestamp).toDate(),
        takenDate: Map<String, bool>.from(entry.value['takenDate'] ?? {}),
      );
    }).toList();

    return medicines;
  } catch (e) {
    print("Error retrieving medicines from Firestore: $e");
    return [];
  }
}
