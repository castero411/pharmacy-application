import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_manager/firebase/get_medicines.dart';
import 'package:medicine_manager/models/medicine.dart';

class CurrentMedicineNotifier extends StateNotifier<List<Medicine>> {
  CurrentMedicineNotifier() : super([]);

  void updateList() async {
    state = await getMedicines();
  }

  List<Medicine> getMedicinesOfTheDay(String date) {
    return state
        .where((medicine) => medicine.takenDate.containsKey(date))
        .toList();
  }
}

final medicineProvider =
    StateNotifierProvider<CurrentMedicineNotifier, List<Medicine>>(
        (ref) => CurrentMedicineNotifier());
