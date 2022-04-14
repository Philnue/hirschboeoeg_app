import 'package:boeoeg_app/classes/Api/terminAbstimmung.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../IOS/widgets/cupertinoAlertDialogCustom.dart';
import '../constants/constants.dart';
import 'dart:convert';

class MitgliedApi {
  static const String getMitliedByIdString =
      Constants.fritzBoxConnection + "Mitglieder/getMitgliedById/";

  static const String addMitliedString =
      Constants.fritzBoxConnection + "Mitglieder/addMitglied/";

  static const String loadAllMitgliederString =
      Constants.fritzBoxConnection + "Mitglieder/loadallmitglieder/";

  static const String updateMitliedString =
      Constants.fritzBoxConnection + "Mitglieder/updatemitgliedwithid/";

  static const String getFullMitgliedByIdString =
      Constants.fritzBoxConnection + "Mitglieder/getFullMitgliedById/";

  static const String addShortNameByIdString =
      Constants.fritzBoxConnection + "Mitglieder/addShortName/";

  static const String updateShortNameByIdString =
      Constants.fritzBoxConnection + "Mitglieder/updateShortname/";

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
      String convertedPath = addMitliedString + "$crrid,$vorname,$nachname";

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
      String convertedPath = addMitliedString + "$vorname,$nachname";

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
          TerminAbstimmungApi.loadAllTerminAbstimmungByTerminString +
              "$terminId";

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
      Uri dataURL = Uri.parse(loadAllMitgliederString);
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
      String custom = getFullMitgliedByIdString + "$id";
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

  static Future<Mitglied> addShortName(
      int mitglied_id, String shortName) async {
    try {
      String custom = addShortNameByIdString + "$mitglied_id,$shortName";
      Uri dataURL = Uri.parse(custom);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static Future<Mitglied> udpateShortName(
      int mitglied_id, String shortName) async {
    try {
      String custom = updateShortNameByIdString + "$mitglied_id,$shortName";
      Uri dataURL = Uri.parse(custom);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Mitglied API load error" + _.toString());
    }
  }

  static void addOrUpdateShortNameCupertino(
      String shortName, BuildContext context) {
    if (HiveHelper.currentSpitzName == "") {
      var m = HiveHelper.writeSpitzName(shortName);

      print("new ${HiveHelper.currentSpitzName}");
      //MitgliedApi.addShortName(HiveHelper.currentId, value);

      CupertinoAlertDialogCustom.showAlertDialog(
        context,
        "Hinzufügen des Spitznamens",
        "Ihr Spitzname $shortName wurde erfolgreich hinzugefügt bitte schließen sie die App und starten diese erneut",
        [
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
              //exit(0);
            },
          )
        ],
      );
    } else {
      var old = HiveHelper.currentSpitzName;
      var m = HiveHelper.writeSpitzName(shortName);

      print("new ${HiveHelper.currentSpitzName}");
      //MitgliedApi.udpateShortName(HiveHelper.currentId, value);

      CupertinoAlertDialogCustom.showAlertDialog(
        context,
        "Update des Spitznamens",
        "Ihr Spitzname $old zu $shortName wurde erfolgreich geändert bitte schließen sie die App und starten diese erneut",
        [
          CupertinoDialogAction(
            child: const Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
              //exit(0);
            },
          )
        ],
      );
    }
  }
}
