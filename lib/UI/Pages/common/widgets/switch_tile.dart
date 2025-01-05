// switch_tile.dart
import 'package:flutter/material.dart';
import '../../../Theme/colors.dart';

class SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSwitched;
  final ValueChanged<bool> onChanged;

  const SwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSwitched,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: SwitchListTile(
        value: isSwitched,
        onChanged: onChanged,
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        secondary: Icon(
          icon,
          size: 30,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
