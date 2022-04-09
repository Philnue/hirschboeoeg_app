import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

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
