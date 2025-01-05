import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/vague_widgets/decorated_box.dart';
import '../../../Provider/provider.dart';

class TimePicker extends ConsumerWidget {
  Time convertToTime(TimeOfDay timeOfDay) {
    return Time(hour: timeOfDay.hour, minute: timeOfDay.minute);
  }

  TimeOfDay convertToTimeOfDay(Time time) {
    return TimeOfDay(hour: time.hour, minute: time.minute);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTime = ref.watch(timeProvider);

    return SizedBox(
      width: double.infinity,
      child: InputBoxDecor(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              showPicker(
                context: context,
                accentColor: Theme.of(context).primaryColor,
                value: convertToTime(selectedTime), // Convert TimeOfDay to Time
                onChange: (newTime) {
                  ref.read(timeProvider.notifier).state = convertToTimeOfDay(
                      newTime); // Convert Time back to TimeOfDay
                },
              ),
            );
          },
          child: Center(
            child: Text(
              selectedTime.format(context),
              style: veryBigTextStyle.copyWith(
                  color: Theme.of(context).iconTheme.color),
            ),
          ),
        ),
      ),
    );
  }
}
