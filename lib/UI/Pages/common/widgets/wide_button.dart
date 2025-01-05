import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class WideButton extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const WideButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Material(
        color: xMainColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          child: Center(
              child: Text(
            title,
            style: bigTextStyle.copyWith(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
