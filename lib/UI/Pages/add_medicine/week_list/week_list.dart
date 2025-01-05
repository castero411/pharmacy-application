import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

List<String> days = [
  'Sat',
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
];

class WeekList extends StatefulWidget {
  const WeekList({super.key, required this.currentWeek});
  final List<String> currentWeek;

  @override
  State<WeekList> createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final dayName in days)
          DayBox(
            name: dayName,
            isOn: widget.currentWeek.contains(dayName),
            onTap: () {
              setState(
                () {
                  if (widget.currentWeek.contains(dayName)) {
                    widget.currentWeek.remove(dayName);
                  } else {
                    widget.currentWeek.add(dayName);
                    print(widget.currentWeek);
                  }
                },
              );
            },
          ),
      ],
    );
  }
}

class DayBox extends StatelessWidget {
  const DayBox({super.key, required this.name, this.isOn = false, this.onTap});
  final String name;
  final bool isOn;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Material(
          color: isOn ? xMainColor : xContainerColor,
          borderRadius: BorderRadius.circular(10),
          borderOnForeground: true,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                name,
                style: smallTextStyle.copyWith(
                    color: isOn ? xScaffoldColorLight : xLightTextColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
