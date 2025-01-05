import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginWithButton extends StatelessWidget {
  final Function()? onTap;
  final double size;
  final IconData faIcon;
  const LoginWithButton(
      {super.key, required this.onTap, this.size = 70, required this.faIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Material(
        borderRadius: BorderRadius.circular(size - size * 0.7),
        elevation: 4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(size - size * 0.7),
          onTap: onTap,
          child: Center(
            child: FaIcon(
              faIcon,
              color: Theme.of(context).primaryColor,
              size: size - 30,
            ),
          ),
        ),
      ),
    );
  }
}
