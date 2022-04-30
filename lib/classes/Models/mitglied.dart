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

  String get getName {
    return spitzName == "" ? fullname : spitzName;
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

    var tt = Mitglied(
        id: json["id"],
        vorname: json["vorname"],
        nachname: json["nachname"],
        spitzName: m);

    return tt;
  }

  static List<Mitglied> mitgliederFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mitglied.getFullMitglied(data);
    }).toList();
  }
}
