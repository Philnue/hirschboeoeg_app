import 'dart:io';

import 'package:flutter/foundation.dart';

class Constants {
  static const String fritzBoxConnection =
      "http://t0orznhg4raqbvfi.myfritz.net:43333/";

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
