class BarcodeData {
  BarcodeData({
    required this.id,
    required this.name,
    required this.amount,
    required this.confirm,
    required this.createdAt,
  });

  int id;
  String name;
  int confirm;
  int amount;
  DateTime createdAt;

  factory BarcodeData.fromJson(Map<String, dynamic> json) => BarcodeData(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        confirm: json["confirm"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "confirm": confirm,
        "created_at": createdAt.toIso8601String(),
      };
}
