import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:boeoeg_app/classes/Models/abstimmungsStimme.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import 'dart:convert';

class AbstimmungsStimmeApi {
  static const String _abstimmungsStimmeSummaryString =
      Constants.fritzBoxConnection + "Abstimmung/summary/";

  static const String addAbstimmungsStimmeString =
      Constants.fritzBoxConnection + "AbstimmungsStimme/addAbstimmungsStimme/";

  static Future<AbstimmungsStimme> loadAllAbstimmungsStimmeByid(int id) async {
    try {
      Uri dataURL = Uri.parse(_abstimmungsStimmeSummaryString + "$id");
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return AbstimmungsStimme.fromJson(_temp);
    } catch (_) {
      throw ("Abstimmung API load error" + _.toString());
    }
  }
}
