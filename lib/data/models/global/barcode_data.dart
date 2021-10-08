class BarcodeData {
  BarcodeData({
    required this.id,
    required this.name,
    required this.amount,
  });

  int id;
  String name;
  int amount;

  factory BarcodeData.fromJson(Map<String, dynamic> json) => BarcodeData(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
      };
}
