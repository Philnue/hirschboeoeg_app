import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class MitgliedApi {
  static Future<int> loadMitliedIdByName(String path) async {
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
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<bool> updateMitlied(
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
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<bool> addMitlied(
      {required String vorname, required String nachname}) async {
    try {
      String convertedPath = Constants.addMitlied + "$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      var m = data[0]["id"];

      bool t =
          await HiveHelper.putValueInt(box: "settings", key: "id", value: m);

      return true;
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<List<Mitglied>> loadTerminAbstimmugPersonsByTerminId({
    required int terminId,
  }) async {
    try {
     
      String convertedPath =
          Constants.loadAllTerminAbstimmungByTermin + "$terminId";

      Uri dataURL = Uri.parse(convertedPath);
 
      http.Response response = await http.get(dataURL);
 

      var data = jsonDecode(utf8.decode(response.bodyBytes)); 
      List _temp = [];
 
      for (var item in data) { 
        _temp.add(item);
      }
      return Mitglied.mitgliederFromSnapshot(_temp);
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<List<Mitglied>> loadallmitglieder() async {
    try {
      Uri dataURL = Uri.parse(Constants.loadAllMitglieder);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return Mitglied.mitgliederFromSnapshot(_temp);
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<Mitglied> loadFullMitgliedById(int id) async {
    try {
      String custom = Constants.getFullMitgliedById + "$id";
      Uri dataURL = Uri.parse(custom);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return Mitglied.getFullMitglied(_temp[0]);
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }
}
