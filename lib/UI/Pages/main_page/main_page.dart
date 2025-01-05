import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medicine_manager/UI/Pages/main_page/bottom_sheet/bottom_sheet.dart';
import 'package:medicine_manager/UI/Pages/main_page/date_picker/date_picker.dart';
import 'package:medicine_manager/UI/Pages/main_page/medicine_list/medicine_list.dart';
import 'package:medicine_manager/UI/Provider/medicine_provider.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:medicine_manager/models/medicine.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  void takeMedicineDialog(
      BuildContext context, WidgetRef ref, Medicine medicine) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return Dialog();
        });
  }

  void showDatePicker(BuildContext context, WidgetRef ref) async {
    final currentDay = ref.watch(dateProvider);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 250),
          child: Material(
            borderRadius: BorderRadius.circular(20),
            child: CalendarDatePicker2(
              onValueChanged: (value) {
                ref.read(dateProvider.notifier).state = value[0];
              },
              value: [currentDay],
              config: CalendarDatePicker2Config(
                selectedDayHighlightColor: Theme.of(context).primaryColor,
                daySplashColor: Theme.of(context).primaryColor.withOpacity(.3),
                calendarType: CalendarDatePicker2Type.single,
              ),
            ),
          ),
        );
      },
    );
  }

  void showBottomSheet(
      BuildContext context, Medicine currentMed, WidgetRef ref) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        builder: (ctx) {
          return BottomSheetMedicine(
            medicine: currentMed,
            ref: ref,
          );
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(medicineProvider.notifier).updateList();
    ref.watch(medicineProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        title: Text("Welcome Back"),
        actions: [
          IconButton(
              onPressed: () {
                showDatePicker(context, ref);
              },
              icon: Icon(Icons.date_range)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "settings");
              },
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: xLightTextColor,
        onPressed: () {
          Navigator.pushNamed(context, 'add_medicine');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Material(
              elevation: 10,
              child: CustomDatePicker(),
            ),
          ),
          Gap(20),
          Expanded(
            flex: 13,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: MedicineList(
                takeMedicine: (medicine) {},
                onHold: (medicine) {
                  showBottomSheet(context, medicine, ref);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
