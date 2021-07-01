class Utils {
  String getDateString(DateTime now) {
    String dateString = now.day.toString() +
        '-' +
        now.month.toString() +
        '-' +
        now.year.toString();
    return dateString;
  }

  String getStringWithoutSpace(String text) {
    return text.replaceAll(" ", "_");
  }

  String getStringWithSpace(String text) {
    return text.replaceAll("_", " ");
  }
}
