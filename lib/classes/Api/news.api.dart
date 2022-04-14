import 'package:boeoeg_app/classes/Models/news.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import 'dart:convert';

class NewsApi {
  static const String _loadAllNewsString =
      Constants.fritzBoxConnection + "Neuigkeiten/loadAllNews/";

  static Future<List<News>> loadAllNews() async {
    try {
      Uri dataURL = Uri.parse(_loadAllNewsString);

      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      List _temp = [];

      for (var item in data) {
        _temp.add(item);
      }

      return News.newsFromSnapshot(_temp);
    } catch (_) {
      throw ("Abstimmung API load error" + _.toString());
    }
  }
}
