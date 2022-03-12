class Constants {
  static const String fritzBoxConnection =
      "http://t0orznhg4raqbvfi.myfritz.net:43333/";
  static const String loadAllTermine =
      fritzBoxConnection + "Termine/loadalltermine/";
  static const String addTerminAbstimmung =
      fritzBoxConnection + "TerminAbstimmung/addTerminAbstimmung/";
  static const String loadAllTerminAbstimmung =
      fritzBoxConnection + "TerminAbstimmung/loadallterminabstimmung/";
  static const String getMitliedById =
      fritzBoxConnection + "Mitglieder/getMitgliedById/";
  static const String addMitlied =
      fritzBoxConnection + "Mitglieder/addMitglied/";
  static const String loadAllMitglieder =
      fritzBoxConnection + "Mitglieder/loadallmitglieder/";
  static const String updateMitlied =
      fritzBoxConnection + "Mitglieder/updatemitgliedwithid/";

  static const String getTerminAbstimmungByMitgliedAnTermin =
      fritzBoxConnection +
          "TerminAbstimmung/loadterminabstimmungbyterminidandmitgliedid/";
  static const String updateTerminAbstimmungByMitgliedAnTermin =
      fritzBoxConnection +
          "TerminAbstimmung/updateterminabstimmungbyterminidandmitgliedid/";
}
