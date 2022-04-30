import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import 'Models/termin.dart';

class HiveHelper {
  static Future<dynamic> getValueDynamic(
      {required String box, required key}) async {
    var value = await Hive.box(box).get(key);

    return value;
  }

  static int getValueInt({required String box, required String key}) {
    var value = Hive.box(box).get(key);

    return value;
  }

  static String getValueString({required String box, required String key}) {
    var value = Hive.box(box).get(key).toString();

    return value == "null" ? "" : value;
  }

  static bool putValue(
      {required String box, required String key, required value}) {
    try {
      Hive.box(box).put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool putValueInt(
      {required String box, required String key, required int value}) {
    try {
      Hive.box(box).put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool putValueBool(
      {required String box, required String key, required bool value}) {
    try {
      Hive.box(box).put(key, value);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool getValueBool({required String box, required String key}) {
    try {
      var t = Hive.box(box).get(key) as bool;
      return t;
    } catch (e) {
      return false;
    }
  }

  static bool get isVerified {
    bool response = getValueBool(box: "settings", key: "verified");

    if (response == null) {
      return false;
    }

    return response;
  }

  static bool get isIdSet {
    return currentId != 0 ? true : false;
  }

  static int get currentId {
    return getValueInt(box: "settings", key: "id");
  }

  static String get currentName {
    return getValueString(box: "settings", key: "name");
  }

  static bool writeName(String name) {
    return putValue(box: "settings", key: "name", value: name);
  }

  static bool putAllTermine(List<Termin> allTermine) {
    try {
      Hive.box("settings").put("termine", allTermine);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<List<Termin>> getallTermine() async {
    return await Hive.box("settings").get("termine");
  }

  static void writeNotificationToDevice(int days, DateTime time) {
    var t = "${time.hour}:${time.minute}";
    Hive.box("settings").put("days", days);
    Hive.box("settings").put("time", time);
  }

  static int get selectedDaysForNotifications {
    var value = Hive.box("settings").get("days");

    if (value == null) {
      return 0;
    } else {
      return value;
    }
  }

  static DateTime get selectedTimeForNotifications {
    var valo = Hive.box("settings").get("time");

    if (valo == null) {
      return DateTime(initValue.year, initValue.month, initValue.day, 08, 00);
    } else {
      return valo;
    }
  }

  static DateTime get initValue {
    return DateTime.now().add(Duration(minutes: 5 - DateTime.now().minute % 5));
  }

  static String get selectedTimeForNotificationsFormat {
    DateTime timeStamp = selectedTimeForNotifications;
    String hour = timeStamp.hour.toString().padLeft(2, '0');
    String minute = timeStamp.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  static String get currentSpitzName {
    var value = Hive.box("settings").get("spitzName").toString();
    return value == "null" ? "" : value;
  }

  static void writeSpitzName(String spitzName) async {
    try {
      var t = await Hive.box("settings").put("spitzName", spitzName);
    } catch (_) {
      print(_.toString());
    }
  }
}
