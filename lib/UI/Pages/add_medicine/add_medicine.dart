import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:medicine_manager/UI/Pages/add_medicine/bottom_button/bottom_button.dart';
import 'package:medicine_manager/UI/Pages/add_medicine/description_field/description_field.dart';
import 'package:medicine_manager/UI/Pages/add_medicine/drop_list/drop_list.dart';
import 'package:medicine_manager/UI/Pages/add_medicine/name_text_field/name_text_field.dart';
import 'package:medicine_manager/UI/Pages/common/widgets/time_picker.dart';
import 'package:medicine_manager/UI/Provider/medicine_provider.dart';
import 'package:medicine_manager/UI/Provider/provider.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';
import 'package:medicine_manager/firebase/add_or_update_medicine.dart';
import 'package:medicine_manager/functions/time/date_to_string.dart';
import 'package:medicine_manager/functions/time/new_date_with_hours.dart';
import 'package:medicine_manager/functions/validation/medicine_form_validator.dart';
import 'package:medicine_manager/models/medicine.dart';

// import 'package:medicine_manager/UI/Provider/add_medicine_providers.dart';
// import 'package:medicine_manager/UI/Pages/add_medicine/week_list/week_list.dart';

class AddMedicine extends ConsumerWidget {
  AddMedicine({super.key});

  final double gapSize = 50;

  final DateTime startingDate = DateTime.now();
  final String currentType = 'pills';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController _doseCountController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _doseController = TextEditingController();

  Medicine createMedicineWithTakenDates({
    required String name,
    required String description,
    required String type,
    required String dose,
    required String doseNumber,
    required DateTime startingDate,
  }) {
    // Parse dose to an integer
    final int doseCount =
        int.tryParse(doseNumber) ?? 0; // Use 0 if parsing fails
    if (doseCount <= 0) {
      throw ArgumentError("Dose must be a positive integer.");
    }

    // Initialize takenDate map
    final Map<String, bool> initializedTakenDates = {};
    for (int i = 0; i < doseCount; i++) {
      DateTime date = startingDate.add(Duration(days: i));
      String formattedDate = formatDate(date);
      initializedTakenDates[formattedDate] = false;
    }

    // Return the Medicine instance
    return Medicine(
      name: name,
      description: description,
      type: type,
      dose: dose,
      doseCount: doseNumber,
      startingDate: startingDate,
      takenDate: initializedTakenDates,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).primaryColor,
        title: Text(
          "Add Medicine",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomButton(
        onTap: () async {
          DateTime currnetDate = DateTime.now();
          TimeOfDay timeOfDay = ref.watch(timeProvider);

          if (_globalKey.currentState!.validate()) {
            await addOrUpdateMedicine(createMedicineWithTakenDates(
              doseNumber: _doseCountController.text,
              description: descriptionController.text,
              name: nameController.text,
              dose: _doseController.text,
              startingDate:
                  editDate(currnetDate, timeOfDay.hour, timeOfDay.minute),
              type: currentType,
            ));
            ref.watch(medicineProvider.notifier).updateList();
            Navigator.pop(context);
          }
        },
        height: 64,
      ),
      body: SafeArea(
        child: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SizedBox(
                          //placeholder for the image uploader
                          width: 70,
                          height: 70,
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      Gap(20),
                      Expanded(
                        flex: 3,
                        child: NameTextField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          text: 'Name',
                          validator: nameValidator,
                        ),
                      ),
                    ],
                  ),
                  Gap(gapSize),
                  Text(
                    "Type",
                    textAlign: TextAlign.left,
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ),
                  DropList(
                    currentValue: currentType,
                  ),
                  Gap(gapSize),
                  Text(
                    "Time",
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ),
                  Center(child: TimePicker()),
                  Gap(gapSize),
                  Text(
                    "Dose",
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ),
                  NameTextField(
                    // must only be a number
                    controller: _doseController,
                    text: "",
                    validator: nameValidator,
                    keyboardType: TextInputType.text,
                  ),
                  Gap(gapSize),
                  Text(
                    "Number of days",
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ),
                  NameTextField(
                    // must only be a number
                    controller: _doseCountController,
                    text: "",
                    validator: hasNumber,
                    keyboardType: TextInputType.number,
                  ),

                  // Gap(gapSize),
                  // Text(
                  //   "Days",
                  //   style: labelTextStyle,
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.sizeOf(context).height / 14,
                  //   child: WeekList(
                  //     currentWeek: daysOfTheWeek,
                  //   ),
                  // ),
                  Gap(gapSize),
                  Text(
                    "Description",
                    style: labelTextStyle.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ),
                  DescriptionField(
                    controller: descriptionController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
