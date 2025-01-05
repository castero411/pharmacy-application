import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_manager/UI/Pages/main_page/medicine_tile_view/medicine_tile.dart';
import 'package:medicine_manager/UI/Provider/medicine_provider.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';
import 'package:medicine_manager/firebase/update_medicine.dart';
import 'package:medicine_manager/functions/time/date_to_string.dart';
import 'package:medicine_manager/functions/time/time_to_string.dart';
import 'package:medicine_manager/models/medicine.dart';

class MedicineList extends ConsumerWidget {
  const MedicineList({
    super.key,
    required this.onHold,
    required this.takeMedicine,
  });
  final Function(Medicine) takeMedicine;
  final Function(Medicine) onHold;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String currentDate = formatDate(ref.watch(dateProvider));

    List<Medicine> currentMedicines =
        ref.watch(medicineProvider.notifier).getMedicinesOfTheDay(currentDate);

    return ListView.builder(
      itemCount: currentMedicines.length,
      itemBuilder: (context, item) {
        String time = formatTime(currentMedicines[item].startingDate);

        return MedicineTile(
          onTapIcon: () async {
            //takeMedicine(currentMedicines[item]);
            await updateMedicineState(currentMedicines[item].name, currentDate);
            ref.read(medicineProvider);
          },
          onTapBody: () {
            onHold(currentMedicines[item]);
          },
          time: time,
          name: currentMedicines[item].name,
          taken: currentMedicines[item].takenDate[currentDate]
              as bool, // This can be updated based on whether the medicine has been taken
        );
      },
    );
  }
}

class SelectedMedicineProvider {}
