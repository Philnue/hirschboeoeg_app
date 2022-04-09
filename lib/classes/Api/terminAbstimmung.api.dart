import 'package:boeoeg_app/classes/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TerminAbstimmungApi {
  static Future<bool> addTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
    required int entscheidung,
  }) async {
    try {
      String convertedPath =
          Constants.addTerminAbstimmung + "$terminId,$mitgliedId,$entscheidung";

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
      String convertedPath = Constants.getTerminAbstimmungByMitgliedAnTermin +
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

  static Future<String> updateTerminAbstimmungByPersonAndTermin({
    required int terminId,
    required int mitgliedId,
    required bool entscheidung,
  }) async {
    try {
      String convertedPath =
          Constants.updateTerminAbstimmungByMitgliedAnTermin +
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
          Constants.deleteTerminAbstimmung + "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      bool data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }
}
