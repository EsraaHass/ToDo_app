// this function is used to extract only date from dateTime
// is used to ignore time anf retuen date

DateTime dateOnly(DateTime dateTime) =>
    DateTime(dateTime.year, dateTime.month, dateTime.day);
