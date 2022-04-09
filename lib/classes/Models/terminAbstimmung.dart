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

  factory TerminAbstimmung.fromJson(dynamic json) {
    bool _bool = json["entscheidung"] == 1 ? true : false;

    return TerminAbstimmung(
        id: json["id"],
        entscheidung: _bool,
        termin: Termin.fromJson(json),
        mitglied: Mitglied.fromJson(json));
  }

  static List<TerminAbstimmung> terminAbstimmungenFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return TerminAbstimmung.fromJson(data);
    }).toList();
  }
}
