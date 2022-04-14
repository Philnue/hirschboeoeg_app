import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../IOS/widgets/cupertinoAlertDialogCustom.dart';
import '../constants/constants.dart';
import 'dart:convert';

import '../hiveHelper.dart';

class AbstimmungApi {
  static const String _getAllAbstimmungenString =
      Constants.fritzBoxConnection + "Abstimmung/getAllAbstimmungen/";

  static const String _deleteAbstimmungString =
      Constants.fritzBoxConnection + "Abstimmung/deleteAbstimmungById/";

  static const String _addAbstimmungString =
      Constants.fritzBoxConnection + "Abstimmung/addAbstimmung/";
  static Future<List<Abstimmung>> loadAllAbstimmungen() async {
    try {
      Uri dataURL = Uri.parse(_getAllAbstimmungenString);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return Abstimmung.abstimmungenFromSnapshot(_temp);
    } catch (_) {
      throw ("Abstimmung API load error" + _.toString());
    }
  }

  static Future<bool> addAbstimmung({
    required int mitglied_id,
    required String frage,
    required String title,
    required String ablaufdatum,
  }) async {
    try {
      //! alle slashes rausfiltern und ersetzen
      Uri dataURL = Uri.parse(
          _addAbstimmungString + "$mitglied_id/$frage/$title/$ablaufdatum");
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      print("Abstimmung API load error" + _.toString());
      return false;
    }
  }

  
}
