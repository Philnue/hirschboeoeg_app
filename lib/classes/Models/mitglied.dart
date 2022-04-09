class Mitglied {
  final int id;
  final String vorname;
  final String nachname;
  //final String spitzname;

  Mitglied({
    required this.id,
    required this.vorname,
    required this.nachname,
    //this.spitzname = ""
  });

  String get fullname {
    return "$vorname $nachname";
  }

  factory Mitglied.fromJson(dynamic json) {
    return Mitglied(
      id: json["id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
      //spitzname: json["spitzname"]
    );
  }

  static Mitglied getFullMitglied(dynamic json) {
    return Mitglied(
      id: json["id"],
      vorname: json["vorname"],
      nachname: json["nachname"],
      //! spitzname
    );
  }

  static List<Mitglied> mitgliederFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mitglied.fromJson(data);
    }).toList();
  }
}
