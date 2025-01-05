import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:medicine_manager/UI/Pages/main_page/bottom_sheet/action_buttons.dart';
import 'package:medicine_manager/UI/Provider/medicine_provider.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/firebase/delete_medicine.dart';
import 'package:medicine_manager/firebase/update_medicine.dart';
import 'package:medicine_manager/functions/time/date_to_string.dart';
import 'package:medicine_manager/functions/time/time_to_string.dart';
import 'package:medicine_manager/models/medicine.dart';

class BottomSheetMedicine extends StatelessWidget {
  const BottomSheetMedicine(
      {super.key, required this.medicine, required this.ref});
  final WidgetRef ref;
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    final CurrentDate = ref.watch(dateProvider);

    final String date = formatDate(CurrentDate);
    return Container(
      height: 430,
      padding: EdgeInsets.all(23),
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Material(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
              child: SizedBox(
                width: 150,
                height: 5,
              )),
          Gap(28),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              "$date, ${formatTime(CurrentDate)}",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color.fromRGBO(173, 173, 173, 1), fontSize: 12),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              medicine.name,
              textAlign: TextAlign.start,
              style: sheetNameTextStyle.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dose",
                style: labelTextStyle,
              ),
              Text(
                medicine.dose,
                style: labelTextStyle.copyWith(fontWeight: FontWeight.normal),
              )
            ],
          ),
          Gap(16),
          Divider(),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: ColumnActionButton(
                  onTap: () {
                    deleteMedicine(medicine.name);
                  },
                  width: double.infinity,
                  height: 100,
                  iconData: FontAwesomeIcons.trashCan,
                  text: 'Delete All',
                ),
              ),
              Gap(16),
              Expanded(
                child: ColumnActionButton(
                  onTap: () {
                    deleteDate(medicine.name, date);
                    ref.read(medicineProvider);
                  },
                  width: double.infinity,
                  height: 100,
                  iconData: FontAwesomeIcons.trashCan,
                  text: 'Delete this',
                ),
              ),
              Gap(16),
              Expanded(
                child: ColumnActionButton(
                  onTap: () async {
                    await updateMedicineState(medicine.name, date);
                    ref.read(medicineProvider);
                  },
                  width: double.infinity,
                  height: 100,
                  iconData: FontAwesomeIcons.circleCheck,
                  text: 'Take',
                ),
              ),
            ],
          ),
          Gap(16),
          RowActionButton(
            height: 70,
            onTap: () {},
            width: double.infinity,
            iconData: FontAwesomeIcons.penToSquare,
            text: 'Edit',
          ),
        ],
      ),
    );
  }
}
