import 'package:boeoeg_app/classes/Api/termin.api.dart';
import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/Models/termin.dart';

class TerminAbstimmung {
  final int id;
  final Termin termin;
  final Mitglied mitglied;
  final bool entscheidung;

  TerminAbstimmung({
    required this.id,
    required this.termin,
    required this.mitglied,
    this.entscheidung = false,
  });
  factory TerminAbstimmung.fromJson(dynamic json, Termin t) {
    bool _bool = json["entscheidung"] == 1 ? true : false;

    Mitglied ttt = Mitglied.getFullMitglied(json);

    return TerminAbstimmung(
      id: json["id"],
      entscheidung: _bool,
      termin: t,
      mitglied: ttt,
    );
  }

  static List<TerminAbstimmung> terminAbstimmungenFromSnapshot(
      List snapshot, Termin t) {
    return snapshot.map((data) {
      return TerminAbstimmung.fromJson(data, t);
    }).toList();
  }
}
