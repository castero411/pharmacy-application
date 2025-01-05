import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class CustomFormField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final FormFieldValidator<String?>? validator;
  final TextEditingController controller;

  const CustomFormField(
      {super.key,
      required this.hint,
      required this.obscure,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      obscureText: obscure,
      validator: validator,
      controller: controller,
      style: Theme.of(context).textTheme.bodySmall,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.only(left: 20, top: 35),
        hintStyle: TextStyle(color: Theme.of(context).hintColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: xEnabledBorder,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: xLightTextColor,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
