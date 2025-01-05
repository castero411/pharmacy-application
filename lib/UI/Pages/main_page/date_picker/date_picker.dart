import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class CustomDatePicker extends ConsumerWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WeeklyDatePicker(
      selectedColor: Theme.of(context).primaryColor,
      selectedDay: ref.watch(dateProvider),
      backgroundColor: xScaffoldColorLight,
      enableWeeknumberText: false,
      changeDay: (selectedDate) {
        ref.read(dateProvider.notifier).state = selectedDate;
      },
    );
  }
}
