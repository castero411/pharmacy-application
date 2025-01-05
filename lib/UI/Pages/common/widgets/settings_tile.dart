import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onTap;
  const SettingsTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 25),
              child: Icon(
                icon,
                size: 30,
                color: Theme.of(context).indicatorColor,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
          ],
        ),
      ),
    );
  }
}
