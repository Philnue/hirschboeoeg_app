import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../format.dart';

class Termin {
  final int id;

  final String name;

  final String datum;

  final String adresse;

  final String uhrzeit;

  final String notizen;

  final String treffpunkt;

  final String kleidung;

  Termin(
      {required this.id,
      required this.name,
      required this.datum,
      required this.adresse,
      required this.uhrzeit,
      required this.notizen,
      required this.treffpunkt,
      required this.kleidung});

  String get getDateCorrectly {
    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .toString()
            .substring(0, 10);
    final tomorrow = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
        .toString()
        .substring(0, 10);

    if (today == datum) {
      return "Heute ";
    }
    if (tomorrow == datum) {
      return "Morgen";
    }
    return datumConvertedInGerman;
  }

  DateTime get terminAsDateTimeWithoutTime {
    //"2022-06-27"
    var year = int.parse(datum.substring(0, 4));
    var month = int.parse(datum.substring(5, 7));
    var day = int.parse(datum.substring(8, 10));

    return DateTime(year, month, day);
  }

  DateTime get terminAsDateTime {
    //"2022-06-27"
    var year = int.parse(datum.substring(0, 4));
    var month = int.parse(datum.substring(5, 7));
    var day = int.parse(datum.substring(8, 10));
    var hour = 00;
    var minute = 00;

    if (uhrzeit != "n.A.") {
      hour = int.parse(uhrzeit.substring(0, 2));
      minute = int.parse(uhrzeit.substring(3, 5));
    }

    return DateTime(year, month, day, hour, minute);
  }

  factory Termin.fromJson(dynamic json) {
    return Termin(
        id: json["id"],
        name: json["name"],
        datum: json["datum"],
        adresse: json["adresse"],
        uhrzeit: json["uhrzeit"].toString(),
        notizen: json["notizen"],
        treffpunkt: json["treffpunkt"],
        kleidung: json["kleidung"]);
  }

  static List<Termin> termineFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Termin.fromJson(data);
    }).toList();
  }

  String get datumConvertedInGerman {
    return Format.convertDateToGerman(datum);
  }
}
