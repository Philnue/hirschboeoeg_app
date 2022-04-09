import 'package:intl/intl.dart';

class Format {
  static String get currentDate {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static String convertDateToGerman(String date) {
    String right = "";

    right += date.substring(8, 10);
    right += ".";
    right += date.substring(5, 7);
    right += ".";
    right += date.substring(0, 4);

    return right;
  }

  static bool get isAcceptTime {
    return DateTime.now().hour < 24 ? true : false;
  }
}
