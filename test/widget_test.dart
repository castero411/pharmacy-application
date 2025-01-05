import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicine_manager/functions/time/date_to_string.dart';

import 'package:medicine_manager/main.dart';

void main() {
  String currentDate = '09/12/2024';

  DateTime thisDAte = parseDate(currentDate);

  print(formatDate(thisDAte));
}
