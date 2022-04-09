import 'package:boeoeg_app/classes/Models/abstimmung.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class AbstimmungApi {
  static Future<List<Abstimmung>> loadAllAbstimmungen() async {
    try {
      Uri dataURL = Uri.parse(Constants.getAllAbstimmungen);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      List _temp = [];

      for (var item in data) {
        print(item);
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
          Constants.addAbstimmung + "$mitglied_id/$frage/$title/$ablaufdatum");
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      print("Abstimmung API load error" + _.toString());
      return false;
    }
  }
}
