import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  // Format the DateTime to "dd/MM/yyyy"
  return DateFormat('dd-MM-yyyy').format(date);
}

DateTime parseDate(String dateStr) {
  try {
    return DateFormat('dd-MM-yyyy').parse(dateStr);
  } catch (e) {
    return DateTime.now(); // Return current date as a fallback
  }
}
