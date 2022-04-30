import 'package:boeoeg_app/classes/Models/termin.dart';
import 'package:boeoeg_app/classes/Models/terminAbstimmung.dart';
import 'package:flutter/material.dart';

class TerminTerminAbstimmung {
  TerminTerminAbstimmung(
      {required this.termin, required this.terminAbstimmung});

  final Termin termin;
  final int terminAbstimmung;

  factory TerminTerminAbstimmung.fromJson(dynamic json, dynamic json2) {
    var termin = Termin.fromJson(json);

    return TerminTerminAbstimmung(
      termin: json[""],
      terminAbstimmung: json[""],
    );
  }

  static List<TerminTerminAbstimmung> getTerminTerminAbstimmungList(
      List<Termin> termine, List<dynamic> terminAbstimmungen) {
    List<TerminTerminAbstimmung> liste = [];
    if (termine.length == terminAbstimmungen.length) {
      var length = termine.length;

      for (int i = 0; i < length; i++) {
        var m = TerminTerminAbstimmung(
            termin: termine[i], terminAbstimmung: terminAbstimmungen[i]);
        liste.add(m);
      }
    }
    return liste;
  }

  static List<TerminTerminAbstimmung> termineTerminAbstimmungFromSnapshot(
      List snapshot) {
    return snapshot.map((data) {
      return TerminTerminAbstimmung.fromJson(data, data);
    }).toList();
  }

  static List<TerminTerminAbstimmung> termineTerminAbstimmungFromSnapshotNew(
      List snapshot, List snapshot2) {
    var terminList = snapshot.map((e) => Termin.fromJson(e)).toList();
    var terminAbstimmungList = snapshot2.map((e) => e).toList();

    return getTerminTerminAbstimmungList(terminList, terminAbstimmungList);
  }
}
