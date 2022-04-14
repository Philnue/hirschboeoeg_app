import 'dart:core';

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

  static DateTime getDateTimeObject(String date, String time) {
    // var m = args.datum as DateTime;
    //             var mm = args.treffpunkt;
    // DateTime tt = DateTime(m.year,m.month, m.day, )

    //2022-03-19
    //12:00
    var year = date.substring(0, 4);
    var month = date.substring(5, 7);
    var day = date.substring(8, 10);

    var hour = "";
    var min = "";

    //! wen uhrzeit n.A. ist

    hour = time.substring(0, 2);
    min = time.substring(3, 5);

    DateTime dt = DateTime(int.parse(year), int.parse(month), int.parse(day),
        int.parse(hour), int.parse(min));
    return dt;
  }

  static DateTime getDateTimeObejectWithMinusDuration(
      String date, String time, Duration duration) {
    return getDateTimeObject(date, time).subtract(duration);
  }

  static String bodyGenerator(int days) {
    String body = "";
    switch (days) {
      case 0:
        body = "heute";
        break;
      case 1:
        body = "morgen";
        break;
      case 2:
        body = "übermorgen";
        break;
      case 3:
        body = "in 3 Tagen";
        break;
      case 4:
        body = "in 4 Tagen";
        break;
      case 5:
        body = "in 5 Tagen";
        break;
    }
    return body;
  }
}
