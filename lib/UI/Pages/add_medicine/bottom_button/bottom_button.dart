import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';

class BottomButton extends StatelessWidget {
  const BottomButton({super.key, required this.onTap, required this.height});
  final Function()? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ColoredBox(
        color: Theme.of(context).primaryColor,
        child: SizedBox(
          height: height,
          child: Center(
            child: Text(
              "Done",
              style: veryBigTextStyle.copyWith(
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
