import 'package:boeoeg_app/classes/Models/mitglied.dart';
import 'package:boeoeg_app/classes/format.dart';

class Abstimmung {
  final int id;
  final Mitglied mitglied;
  final String erstellungsDatum;
  final String erstellungsUhrzeit;
  final String frage;
  final String titel;
  final String ablaufDatum;

  Abstimmung(
      {required this.id,
      required this.erstellungsDatum,
      required this.erstellungsUhrzeit,
      required this.ablaufDatum,
      required this.frage,
      required this.mitglied,
      required this.titel});

  factory Abstimmung.fromJson(dynamic json) {
    Mitglied t = Mitglied(
      id: json["mitglied_id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
    );
    return Abstimmung(
        id: json["Abstimmung.id"],
        erstellungsDatum: json["erstellungsDatum"],
        erstellungsUhrzeit: json["erstellungsUhrzeit"],
        frage: json["frage"],
        titel: json["titel"],
        ablaufDatum: json["ablaufDatum"],
        mitglied: t);
  }

  static List<Abstimmung> abstimmungenFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Abstimmung.fromJson(data);
    }).toList();
  }

  String get erstellungsDatumConverted {
    return Format.convertDateToGerman(erstellungsDatum);
  }

  String get ablaufDatumConverted {
    return Format.convertDateToGerman(ablaufDatum);
  }
}
