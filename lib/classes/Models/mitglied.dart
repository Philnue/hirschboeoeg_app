class Mitglied {
  final int id;
  final String vorname;
  final String nachname;
  final String spitzName;

  Mitglied(
      {required this.id,
      required this.vorname,
      required this.nachname,
      this.spitzName = ""});

  String get fullname {
    return "$vorname $nachname";
  }

  factory Mitglied.fromJson(dynamic json) {
    return Mitglied(
      id: json["id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
    );
  }

  static Mitglied getFullMitglied(dynamic json) {
    String m = "";
    if (json["spitzName"] != null) {
      m = json["spitzName"];
    }

    return Mitglied(
        id: json["id"],
        vorname: json["vorname"],
        nachname: json["nachname"],
        spitzName: m);
  }

  static List<Mitglied> mitgliederFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mitglied.getFullMitglied(data);
    }).toList();
  }
}
