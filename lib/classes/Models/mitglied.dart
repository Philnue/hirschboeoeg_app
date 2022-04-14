class Mitglied {
  final int id;
  final String vorname;
  final String nachname;
  final String spitzName;

  Mitglied({
    required this.id,
    required this.vorname,
    required this.nachname,
    this.spitzName = ""
  });

  String get fullname {
    return "$vorname $nachname";
  }

  factory Mitglied.fromJson(dynamic json) {
    return Mitglied(
      id: json["id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
      spitzName: json["spitzName"]
    );
  }

  static Mitglied getFullMitglied(dynamic json) {
    return Mitglied(
      id: json["id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
     spitzName: json["spitzName"]
    );
  }

  static List<Mitglied> mitgliederFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mitglied.fromJson(data);
    }).toList();
  }
}
