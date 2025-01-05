import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class ColumnActionButton extends StatelessWidget {
  const ColumnActionButton(
      {super.key,
      required this.onTap,
      required this.width,
      required this.height,
      required this.iconData,
      required this.text});
  final Function() onTap;
  final double width;
  final double height;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: xTakenColor,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 24,
                color: Theme.of(context).primaryColor,
              ),
              Gap(10),
              Text(
                text,
                style: smallTextStyle.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          )),
    );
  }
}

class RowActionButton extends StatelessWidget {
  const RowActionButton(
      {super.key,
      required this.onTap,
      required this.width,
      required this.height,
      required this.iconData,
      required this.text});
  final Function() onTap;
  final double width;
  final double height;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: xTakenColor,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 24,
                color: Theme.of(context).primaryColor,
              ),
              Gap(20),
              Text(
                text,
                style: smallTextStyle.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          )),
    );
  }
}
