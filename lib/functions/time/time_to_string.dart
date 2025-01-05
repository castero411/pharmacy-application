import 'package:intl/intl.dart';

String formatTime(DateTime date) {
  // Format the DateTime to "hh:mm a" (12-hour time format with AM/PM)
  return DateFormat('hh:mm a').format(date);
}
