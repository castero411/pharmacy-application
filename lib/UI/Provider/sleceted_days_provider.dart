import 'package:flutter_riverpod/flutter_riverpod.dart';

class DaysNotifier extends StateNotifier<List<String>> {
  DaysNotifier() : super([]);

  void addDay(String day) {
    state = [...state, day];
  }

  void removeDay(String day) {
    state = state.where((d) => d != day).toList();
  }

  bool hasDay(String day) {
    if (state.contains(day)) {
      return true;
    } else {
      return false;
    }
  }
}

final selectedDaysProvider =
    StateNotifierProvider<DaysNotifier, List<String>>((ref) => DaysNotifier());
