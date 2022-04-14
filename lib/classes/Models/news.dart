class News {
  final int id;
  final String erstellungsDatum;
  final String neuigkeit;

  News({
    required this.id,
    required this.erstellungsDatum,
    required this.neuigkeit,
  });

  factory News.fromJson(dynamic json) {
    return News(
      id: json["id"],
      erstellungsDatum: json["erstellungsDatum"],
      neuigkeit: json["neuigkeit"],
    );
  }

  static List<News> newsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return News.fromJson(data);
    }).toList();
  }
}
