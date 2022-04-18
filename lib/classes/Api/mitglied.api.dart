import 'package:boeoeg_app/classes/Api/terminAbstimmung.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/hiveHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../Android/AndroidAlertDialogCustom.dart';
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

  static const String getFullMitgliedByNameString =
      Constants.fritzBoxConnection + "Mitglieder/getFullMitgliedByName/";

  static const String deleteShortNameString =
      Constants.fritzBoxConnection + "Mitglieder/deleteShortname/";
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
      throw ("Mitglied API loadMitliedIdByName" + _.toString());
    }
  }

  static Future<bool> updateMitlied(
      {required int crrid,
      required String vorname,
      required String nachname}) async {
    try {
      String convertedPath = updateMitliedString + "$crrid,$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Mitglied API update Mitglied" + _.toString());
    }
  }

  static Future<bool> addMitlied(
      {required String vorname, required String nachname}) async {
    try {
      String convertedPath = addMitliedString + "$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      var m = data[0]["id"]; //! heir api alles zurückgeben nur funktion andere
      var tt = await loadFullMitgliedById(m);

      Hive.box("settings").put("spitzName", tt.spitzName);

      await HiveHelper.putValueInt(box: "settings", key: "id", value: m);

      return true;
    } catch (_) {
      throw ("Mitglied API add Mitglied" + _.toString());
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
      throw ("Mitglied API loadTerminAbstimmugPersonsByTerminId" +
          _.toString());
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
      throw ("Mitglied API loadallmitglieder" + _.toString());
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
      throw ("Mitglied API loadFullMitgliedById" + _.toString());
    }
  }

  static Future<bool> addShortName(int mitglied_id, String shortName) async {
    try {
      String custom = addShortNameByIdString + "$mitglied_id,$shortName";
      Uri dataURL = Uri.parse(custom);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Mitglied API addShortName" + _.toString());
    }
  }

  static Future<bool> udpateShortName(int mitglied_id, String shortName) async {
    try {
      String custom = "";

      if (shortName != "") {
        custom = updateShortNameByIdString + "$mitglied_id,$shortName";
      } else {
        custom = deleteShortNameString + "$mitglied_id";
      }

      Uri dataURL = Uri.parse(custom);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Mitglied API udpateShortName" + _.toString());
    }
  }

  static Future<Mitglied> loadFullMitliedByName(
      String vorname, String nachname) async {
    try {
      Uri dataURL =
          Uri.parse(getFullMitgliedByNameString + "$vorname,$nachname");

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List _temp = [];

      if (data != null) {
        for (var item in data) {
          _temp.add(item);
        }
      }

      return Mitglied.getFullMitglied(_temp[0]);
    } catch (_) {
      throw ("Mitglied API loadFullMitliedByName" + _.toString());
    }
  }

  static void addOrUpdateShortNameCupertino(
      String shortName, BuildContext context) {
    if (HiveHelper.currentSpitzName == "") {
      var m = HiveHelper.writeSpitzName(shortName);

      var tt = MitgliedApi.addShortName(HiveHelper.currentId, shortName);

      CupertinoAlertDialogCustom.showAlertDialog(
        context,
        "Hinzufügen des Spitznamens",
        "Ihr Spitzname $shortName wurde erfolgreich hinzugefügt",
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

      var mm = MitgliedApi.udpateShortName(HiveHelper.currentId, shortName);

      CupertinoAlertDialogCustom.showAlertDialog(
        context,
        "Update des Spitznamens",
        "Ihr Spitzname $old zu $shortName wurde erfolgreich geändert",
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

  static void addOrUpdateShortNameAndroid(
      String shortName, BuildContext context) {
    if (HiveHelper.currentSpitzName == "") {
      var m = HiveHelper.writeSpitzName(shortName);

      var tt = MitgliedApi.addShortName(HiveHelper.currentId, shortName);

      AndroidAlertDialogCustom.showAlertDialog("Spitzname wurde hinzugefügt",
          "Spitzname $shortName wurde hinzugefügt", context, [
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]);
    } else {
      var old = HiveHelper.currentSpitzName;
      var m = HiveHelper.writeSpitzName(shortName);

      var mm = MitgliedApi.udpateShortName(HiveHelper.currentId, shortName);

      AndroidAlertDialogCustom.showAlertDialog("Spitzname wurde geändert",
          "Spitzname wurde von $old zu $shortName geändert", context, [
        TextButton(
          child: Text("Ok"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ]);
    }
  }
}
