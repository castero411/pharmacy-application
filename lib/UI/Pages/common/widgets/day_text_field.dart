import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../Provider/provider.dart';
import '../../../Theme/Text_style.dart';
import '../../../Theme/colors.dart';

class DayTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isMedicineSelected;
  final List<SelectedListItem>? day;
  final WidgetRef ref;

  const DayTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isMedicineSelected,
    required this.ref,
    this.day,
    Key? key,
  }) : super(key: key);

  void _onTextFieldTap(BuildContext context) {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: Text(
          "Select your Medicine",
          style: bigTextStyle,
        ),
        data: day ?? [],
        onSelected: (List<dynamic> selectedList) {
          List<String> selectedPeriods = selectedList
              .whereType<SelectedListItem>()
              .map((item) => item.name)
              .toList();

          // Update the state using WidgetRef
          ref.read(selectedPeriodsProvider.notifier).state = selectedPeriods;
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    // Watch the selected medicines from the provider
    final selectedPeriods = ref.watch(selectedPeriodsProvider);

    // Update the controller text to display the selected medicines
    textEditingController.text = selectedPeriods.join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
          controller: textEditingController,
          cursorColor: xLightTextColor,
          onTap: isMedicineSelected
              ? () {
                  FocusScope.of(context).unfocus();
                  _onTextFieldTap(context);
                }
              : null,
          readOnly: isMedicineSelected,
          decoration: InputDecoration(
            filled: true,
            fillColor: xLightButtonColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            hintText: selectedPeriods.isEmpty ? hint : null,
            border: const OutlineInputBorder(
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
