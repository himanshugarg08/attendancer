class Utils {
  String getDateString(DateTime now) {
    String dateString = now.day.toString() +
        '-' +
        now.month.toString() +
        '-' +
        now.year.toString();
    return dateString;
  }
}
