DateTime editDate(DateTime date, int newHour, int newMinute) {
  // Update only the hour of the DateTime, keeping other fields unchanged
  return DateTime(
    date.year,
    date.month,
    date.day,
    newHour,
    newMinute,
    date.second,
    date.millisecond,
    date.microsecond,
  );
}
