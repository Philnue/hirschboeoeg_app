import 'package:boeoeg_app/classes/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'termine.dart';

class HttpHelper {
  //! ändern
  Future<List<Termin>> loadAllTermine(String path) async {
    try {
      Uri dataURL = Uri.parse(path);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      List<Termin> liste = [];

      for (var item in data) {
        liste.add(Termin(
            id: item["id"],
            name: item["name"],
            datum: item["datum"],
            adresse: item["adresse"],
            uhrzeit: item["uhrzeit"].toString(),
            notizen: item["notizen"],
            treffpunkt: item["treffpunkt"],
            kleidung: item["kleidung"]));
      }

      return liste;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  //! ändern
  Future<int> loadMitliedIdByName(String path) async {
    try {
      Uri dataURL = Uri.parse(path);

      http.Response response = await http.get(dataURL);

      List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      int id = 0;

      if (data.isNotEmpty) {
        id = data[0]["id"];
        return id;
      }

      return 0;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> updateMitlied(
      {required int crrid,
      required String vorname,
      required String nachname}) async {
    try {
      String convertedPath =
          Constants.updateMitlied + "$crrid,$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> addMitlied(
      {required String vorname, required String nachname}) async {
    try {
      String convertedPath = Constants.addMitlied + "$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> addTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
    required int entscheidung,
  }) async {
    try {
      String convertedPath =
          Constants.addTerminAbstimmung + "$terminId,$mitgliedId,$entscheidung";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<bool> getTerminAbstimmungByPersonAndTermin({
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
      throw ("API load error" + _.toString());
    }
  }

  Future<String> updateTerminAbstimmungByPersonAndTermin({
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
      throw ("API load error" + _.toString());
    }
  }

  Future<String> deleteTerminAbstimmung({
    required int terminId,
    required int mitgliedId,
  }) async {
    try {
      String convertedPath =
          Constants.deleteTerminAbstimmung + "$mitgliedId,$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<List<String>> loadTerminAbstimmugPersonsByTerminId({
    required int terminId,
  }) async {
    try {
      String convertedPath =
          Constants.loadAllTerminAbstimmungByTermin + "$terminId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      List<String> s = [];

      for (var t in data) {
        String m = "";

        m += t["vorname"];
        m += " ";
        m += t["nachname"];

        s.add(m);
      }

      return s;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }
}
