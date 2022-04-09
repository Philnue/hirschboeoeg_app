import 'dart:io';

import 'package:flutter/foundation.dart';

class Constants {
  static const String fritzBoxConnection =
      "http://t0orznhg4raqbvfi.myfritz.net:43333/";

  static const String loadAllTermine =
      fritzBoxConnection + "Termine/loadalltermine/";
  static const String addTerminAbstimmung =
      fritzBoxConnection + "TerminAbstimmung/addTerminAbstimmung/";
  static const String loadAllTerminAbstimmung =
      fritzBoxConnection + "TerminAbstimmung/loadallterminabstimmung/";
  static const String getMitliedById =
      fritzBoxConnection + "Mitglieder/getMitgliedById/";
  static const String addMitlied =
      fritzBoxConnection + "Mitglieder/addMitglied/";
  static const String loadAllMitglieder =
      fritzBoxConnection + "Mitglieder/loadallmitglieder/";
  static const String updateMitlied =
      fritzBoxConnection + "Mitglieder/updatemitgliedwithid/";

  static const String getTerminAbstimmungByMitgliedAnTermin =
      fritzBoxConnection +
          "TerminAbstimmung/loadterminabstimmungbyterminidandmitgliedid/";
  static const String updateTerminAbstimmungByMitgliedAnTermin =
      fritzBoxConnection +
          "TerminAbstimmung/updateterminabstimmungbyterminidandmitgliedid/";

  static const String deleteTerminAbstimmung =
      fritzBoxConnection + "TerminAbstimmung/deleteterminabstimmung/";

  static const String loadAllTerminAbstimmungByTermin =
      fritzBoxConnection + "TerminAbstimmung/loadAllTerminZusagenByTerminId/";

  static const String getAllAbstimmungen =
      fritzBoxConnection + "Abstimmung/getAllAbstimmungen/";

  static const String deleteAbstimmung =
      fritzBoxConnection + "Abstimmung/deleteAbstimmungById/";

  static const String addAbstimmung =
      fritzBoxConnection + "Abstimmung/addAbstimmung/";

  static const String addAbstimmungsStimme =
      fritzBoxConnection + "AbstimmungsStimme/addAbstimmungsStimme/";

  static const String getFullMitgliedById =
      fritzBoxConnection + "Mitglieder/getFullMitgliedById/";

  static const String license = fritzBoxConnection + "Lizens/verifylicense/";

  static List<Map> aemterMap = [
    {"Amt": "Alpha        ", "Name": "Daniel Lauer"},
    {"Amt": "Beta         ", "Name": "Philipp Nüßlein"},
    {"Amt": "Schriftführer", "Name": "Dennis Hofmann"},
    {"Amt": "Finanzen     ", "Name": "Uwe Ziefle"},
  ];

  static final List months = [
    'Jan',
    'Feb',
    'Mrz',
    'Apr',
    'Mai',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Okt',
    'Nov',
    'Dez'
  ];

  static Future<bool> checkInternetConnection() async {
    var _isConnected = false;
    try {
      final response =
          await InternetAddress.lookup(Constants.fritzBoxConnection);
      if (response.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException catch (err) {
      _isConnected = false;

      if (kDebugMode) {
        print(err);
      }
    }
    return _isConnected;
  }
}
