import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class InputBoxDecor extends StatelessWidget {
  const InputBoxDecor({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: xLightTextColor, width: 2),
        ),
      ),
      child: child,
    );
  }
}
