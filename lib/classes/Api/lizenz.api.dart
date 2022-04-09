import 'package:http/http.dart' as http;
import '../constants.dart';
import 'dart:convert';

class LizenzApi {
  static Future<bool> isVerified(String license) async {
    try {
      Uri dataURL = Uri.parse(Constants.license + "$license");

      print(dataURL);
      http.Response response = await http.get(dataURL);
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("Abstimmung API load error" + _.toString());
    }
  }
}