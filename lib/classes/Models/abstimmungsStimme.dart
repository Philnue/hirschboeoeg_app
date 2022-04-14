class AbstimmungsStimme {
  final int registrierteMitglieder;
  final int yes;
  final int no;

  AbstimmungsStimme(
      {required this.registrierteMitglieder,
      required this.yes,
      required this.no});

  factory AbstimmungsStimme.fromJson(List json) {
    int aktzeptiert = 0;
    int nichtAkzeptiert = 0;
    int alleMitglieder = 0;
    for (Map item in json) {
      if (item["entscheidung"] == 1) {
        aktzeptiert = item["count(entscheidung)"];
      }
      if (item["entscheidung"] == 0) {
        nichtAkzeptiert = item["count(entscheidung)"];
      }
      if (item["registrierteMitglieder"] != null) {
        alleMitglieder = item["registrierteMitglieder"];
      }
    }

    return AbstimmungsStimme(
      yes: aktzeptiert,
      no: nichtAkzeptiert,
      registrierteMitglieder: alleMitglieder,
    );
  }
}
