import 'package:intl/intl.dart';

class Format {
  static String currentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }
}
