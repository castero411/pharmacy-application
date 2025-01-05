import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String name;
  final String description;
  final String type;
  final String dose;
  final String doseCount;
  final DateTime startingDate;
  final Map<String, bool> takenDate;

  Medicine({
    required this.type,
    required this.name,
    required this.description,
    required this.dose,
    required this.doseCount,
    required this.startingDate,
    required this.takenDate,
  });

  // Convert Medicine object to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'type': type,
      'dose': dose,
      'doseCount': doseCount,
      'startingDate': startingDate,
      'takenDate': takenDate,
    };
  }

  // Convert Firestore document data to a Medicine object
  factory Medicine.fromMap(Map<String, dynamic> data) {
    return Medicine(
      type: data['type'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      dose: data['dose'] ?? '',
      doseCount: data["doseCount"] ?? '',
      startingDate:
          (data['startingDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      takenDate: Map<String, bool>.from(data['takenDate'] ?? {}),
    );
  }
}
