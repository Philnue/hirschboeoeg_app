import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class TerminApi {
  static Future<List<Termin>> loadAllTermine() async {
    try {
      Uri dataURL = Uri.parse(Constants.loadAllTermine);
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
}
