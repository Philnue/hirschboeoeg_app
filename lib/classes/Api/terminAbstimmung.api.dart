import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/termin.dart';
import 'notification.api.dart';

class TerminAbstimmungApi {
  static const String getTerminAbstimmungByMitgliedAnTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadterminabstimmungbyterminidandmitgliedid/";
  static const String updateTerminAbstimmungByMitgliedAnTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/updateterminabstimmungbyterminidandmitgliedid/";

  static const String deleteTerminAbstimmungString =
      Constants.fritzBoxConnection + "TerminAbstimmung/deleteterminabstimmung/";

  static const String loadAllTerminAbstimmungByTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadAllTerminZusagenByTerminId/";

  static const String addTerminAbstimmungString =
      Constants.fritzBoxConnection + "TerminAbstimmung/addTerminAbstimmung/";
  static const String loadAllTerminAbstimmungStringString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadallterminabstimmung/";

  static Future<bool> addTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
    required int entscheidung,
  }) async {
    try {
      String convertedPath =
          addTerminAbstimmungString + "$terminId,$mitgliedId,$entscheidung";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      bool data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<bool> getTerminAbstimmungByPersonAndTermin({
    required int terminId,
    required int mitgliedId,
  }) async {
    try {
      String convertedPath =
          getTerminAbstimmungByMitgliedAnTerminString + "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      List data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data.isNotEmpty) {
        if (data[0]["entscheidung"] == 1) {
          return true;
        }
        if (data[0]["entscheidung"] == 0) {
          return false;
        }
      }

      return false;
      //return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<String> updateTerminAbstimmungByPersonAndTermin({
    required int terminId,
    required int mitgliedId,
    required bool entscheidung,
  }) async {
    try {
      String convertedPath = updateTerminAbstimmungByMitgliedAnTerminString +
          "$terminId,$mitgliedId, $entscheidung";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<bool> deleteTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
  }) async {
    try {
      String convertedPath =
          deleteTerminAbstimmungString + "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      bool data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static void addOrUpdateTerminAbstimmung(dynamic value, Termin termin) {
    if (value == "add") {
      TerminAbstimmungApi.addTerminAbstimmung(
        terminId: termin.id,
        mitgliedId: HiveHelper.currentId,
        entscheidung: 1,
      );

      NotificationApi.showNotificationWithTermin(termin);
    }

    if (value == "delete") {
      TerminAbstimmungApi.deleteTerminAbstimmung(
          terminId: termin.id, mitgliedId: HiveHelper.currentId);

      NotificationApi.cancel(termin.id);
    }
  }
}
