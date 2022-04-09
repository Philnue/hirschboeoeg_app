class Lizenz {
  final int id;
  final String license;
  final int amount;

  Lizenz({
    required this.id,
    required this.license,
    required this.amount,
  });

  factory Lizenz.fromJson(dynamic json) {
    return Lizenz(
      id: json["id"],
      license: json["license"],
      amount: json["amount"],
    );
  }

  static List<Lizenz> mitgliederFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Lizenz.fromJson(data);
    }).toList();
  }
}
