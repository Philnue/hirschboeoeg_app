import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import 'dart:convert';

class TerminApi {
  static const String loadTerminByIdString =
      Constants.fritzBoxConnection + "Termine/loadTerminById/";
  static const String loadAllTermineString =
      Constants.fritzBoxConnection + "Termine/loadalltermine/";

  static Future<List<Termin>> loadAllTermine() async {
    try {
      //! vllr hier offline rein wenn offline dann aus hvie ladne
      Uri dataURL = Uri.parse(loadAllTermineString);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return Termin.termineFromSnapshot(_temp);
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }

  static Future<Termin> loadTerminById(String terminId) async {
    try {
      //! vllr hier offline rein wenn offline dann aus hvie ladne
      Uri dataURL = Uri.parse(loadTerminByIdString + terminId);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return Termin.fromJson(_temp[0]);
    } catch (_) {
      throw ("Termin API load error" + _.toString());
    }
  }
}
