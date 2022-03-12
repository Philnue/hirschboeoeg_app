import "constants.dart" as consts;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show utf8;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'termine.dart';

class HttpHelper {
  Future<List<Termin>> loadAllTermine(String path) async {
    try {
      Uri dataURL = Uri.parse(path);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;

      List<Termin> liste = [];

      for (var item in data) {
        liste.add(Termin(
            id: item["id"],
            name: item["name"],
            datum: item["datum"],
            adresse: item["adresse"],
            uhrzeit: item["uhrzeit"].toString(),
            notizen: item["notizen"],
            treffpunkt: item["treffpunkt"],
            kleidung: item["kleidung"]));
      }

      return liste;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<int> loadMitliedIdByName(String path) async {
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
      throw ("API load error" + _.toString());
    }
  }

  Future<String> updateMitlied(
      {required String path,
      required int crrid,
      required String vorname,
      required String nachname}) async {
    try {
      String convertedPath = path + "$crrid,$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> addMitlied(
      {required String path,
      required String vorname,
      required String nachname}) async {
    try {
      String convertedPath = path + "$vorname,$nachname";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> addTerminAbstimmung({
    required String path,
    required int terminId,
    required int mitgliedId,
    required bool entscheidung,
  }) async {
    try {
      String convertedPath = path + "$terminId,$mitgliedId,$entscheidung";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<bool> getTerminAbstimmungByPersonAndTermin({
    required String path,
    required int terminId,
    required int mitgliedId,
  }) async {
    try {
      String convertedPath = path + "$terminId,$mitgliedId";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data == "true") {
        return true;
      }
      if (data == "false") {
        return false;
      }
      return false;
      //return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }

  Future<String> updateTerminAbstimmungByPersonAndTermin({
    required String path,
    required int terminId,
    required int mitgliedId,
    required bool entscheidung,
  }) async {
    try {
      String convertedPath = path + "$terminId,$mitgliedId, $entscheidung";

      Uri dataURL = Uri.parse(convertedPath);

      http.Response response = await http.get(dataURL);

      String data = jsonDecode(utf8.decode(response.bodyBytes));

      return data;
    } catch (_) {
      throw ("API load error" + _.toString());
    }
  }
}
