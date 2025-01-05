import 'package:flutter/material.dart';
import 'package:medicine_manager/UI/Theme/Text_style.dart';
import 'package:medicine_manager/UI/Theme/colors.dart';

class NameTextField extends StatelessWidget {
  const NameTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.validator,
    required this.keyboardType,
  });

  final TextEditingController controller;
  final String text;
  final FormFieldValidator validator;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        style: textFieldEntry,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        autocorrect: false,
        cursorColor: Theme.of(context).iconTheme.color,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).iconTheme.color!,
              width: 2,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).iconTheme.color!,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
