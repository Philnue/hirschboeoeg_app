import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/classes/Models/terminAbstimmung.dart';
import 'package:boeoeg_app/classes/constants/constants.dart';
import 'package:boeoeg_app/classes/format.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/termin.dart';
import '../Models/terminTerminAbstimmung.dart';
import 'notification.api.dart';

class TerminAbstimmungApi {
  static const String _getTerminAbstimmungByMitgliedAnTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadterminabstimmungbyterminidandmitgliedid/";
  static const String _updateTerminAbstimmungByMitgliedAnTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/updateterminabstimmungbyterminidandmitgliedid/";

  static const String _deleteTerminAbstimmungString =
      Constants.fritzBoxConnection + "TerminAbstimmung/deleteterminabstimmung/";

  static const String loadAllTerminAbstimmungByTerminString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadAllTerminZusagenByTerminId/";

  static const String _addTerminAbstimmungString =
      Constants.fritzBoxConnection + "TerminAbstimmung/addTerminAbstimmung/";
  static const String _loadAllTerminAbstimmungStringString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadallterminabstimmung/";

  static const String _loadLlTerminAbstimmungenListByTerminIdString =
      Constants.fritzBoxConnection +
          "TerminAbstimmung/loadAllTerminAbstimmungeListByTerminId/";

  static const String _loadCountsString =
      Constants.fritzBoxConnection + "TerminAbstimmung/loadCounts/";

  static Future<bool> addTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
    required int entscheidung,
  }) async {
    try {
      String convertedPath =
          _addTerminAbstimmungString + "$terminId,$mitgliedId,$entscheidung";

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
      String convertedPath = _getTerminAbstimmungByMitgliedAnTerminString +
          "$mitgliedId,$terminId";

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

  static Future<bool> updateTerminAbstimmungByPersonAndTermin({
    required int terminId,
    required int mitgliedId,
    required int entscheidung,
  }) async {
    try {
      String convertedPath = _updateTerminAbstimmungByMitgliedAnTerminString +
          "$mitgliedId,$terminId,$entscheidung";

//! update mit 0, 1 in datenbank
      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return true;
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
          _deleteTerminAbstimmungString + "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      bool data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<void> addOrUpdateTerminAbstimmung(
      dynamic value, Termin termin) async {
    var currentEntscheidung =
        await TerminAbstimmungApi.getTerminAbstimmungIntByPersonAndTerminNew(
            terminId: termin.id, mitgliedId: HiveHelper.currentId);

    if (value == "add") {
      //! des dort rein machen
      if (currentEntscheidung == 0) {
        await TerminAbstimmungApi.addTerminAbstimmung(
          terminId: termin.id,
          mitgliedId: HiveHelper.currentId,
          entscheidung: 1,
        );

        NotificationApi.showNotificationWithTermin(termin);
      }

      if (currentEntscheidung == 2) {
        await TerminAbstimmungApi.updateTerminAbstimmungByPersonAndTermin(
          terminId: termin.id,
          mitgliedId: HiveHelper.currentId,
          entscheidung: 1,
        );

        NotificationApi.showNotificationWithTermin(termin);
      }
    }

    if (value == "delete") {
      if (currentEntscheidung == 0) {
        var tt = await TerminAbstimmungApi.addTerminAbstimmung(
          terminId: termin.id,
          mitgliedId: HiveHelper.currentId,
          entscheidung: 2,
        );

        //Hier
      }
      if (currentEntscheidung == 1) {
        var tt =
            await TerminAbstimmungApi.updateTerminAbstimmungByPersonAndTermin(
                terminId: termin.id,
                mitgliedId: HiveHelper.currentId,
                entscheidung: 2);
      }

      // await TerminAbstimmungApi.deleteTerminAbstimmung(
      //     terminId: termin.id, mitgliedId: HiveHelper.currentId);

      // NotificationApi.cancel(termin.id);

      NotificationApi.cancel(termin.id);
    }
  }

  static Future<int> getTerminAbstimmungIntByPersonAndTerminNew({
    required int terminId,
    required int mitgliedId,
  }) async {
    try {
      String convertedPath = _getTerminAbstimmungByMitgliedAnTerminString +
          "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      List data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data.isNotEmpty) {
        if (data[0]["entscheidung"] == 1) {
          return 1;
        }
        if (data[0]["entscheidung"] == 0) {
          return 0;
        }
        if (data[0]["entscheidung"] == 2) {
          return 2;
        }
      }

      return 0;
      //return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<Map<String, int>> getCountsForTermin(
      {required int terminId}) async {
    try {
      String convertedPath = _loadCountsString + "$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);
      List data = jsonDecode(utf8.decode(response.bodyBytes));

      Map<String, int> m = {
        "kommen": 0,
        "abgelehnt": 0,
        "registrierteMitglieder": 0,
      };

      for (Map<String, dynamic> item in data) {
        if (item["entscheidung"] != null && item["entscheidung"] == 1) {
          m["kommen"] = item["anzahl"];
        }
        if (item["entscheidung"] != null && item["entscheidung"] == 2) {
          m["abgelehnt"] = item["anzahl"];
        }
        if (item["registrierteMitglieder"] != null &&
            item["registrierteMitglieder"] >= 0) {
          m["registrierteMitglieder"] = item["registrierteMitglieder"];
        }
      }

      return m;
    } catch (_) {
      throw ("TerminAbstimmung load counts load error " + _.toString());
    }
  }

  static void makeSaufiMode(
      List<TerminTerminAbstimmung> _terminTerminAbstimmungen) {
    var today = DateTime.now();

    var todayList = _terminTerminAbstimmungen.where((element) =>
        (today.isSameDate(element.termin.terminAsDateTimeWithoutTime) &&
            element.terminAbstimmung == 1 &&
            today.isAfter(element.termin.terminAsDateTime)));

    if (todayList.isNotEmpty) {
      Hive.box("settings").put("saufiAktiviert", true);
    }
    if (todayList.isEmpty) {
      Hive.box("settings").put("saufiAktiviert", false);
    }
  }

  static Future<List<TerminAbstimmung>> loadListTerminAbstimmungByTerminId(
      int terminId) async {
    try {
      String convertedPath =
          _loadLlTerminAbstimmungenListByTerminIdString + "$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var list = [];

      Termin termin = await TerminApi.loadTerminById(terminId.toString());

      for (var item in data) {
        list.add(item);
      }

      return TerminAbstimmung.terminAbstimmungenFromSnapshot(list, termin);
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }
}
