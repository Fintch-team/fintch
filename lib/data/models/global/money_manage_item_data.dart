class MoneyManageItemData {
  MoneyManageItemData({
    required this.id,
    required this.name,
    required this.percent,
    required this.amount,
  });

  int id;
  String name;
  int percent;
  int amount;

  factory MoneyManageItemData.fromJson(Map<String, dynamic> json) =>
      MoneyManageItemData(
        id: json["id"],
        name: json["name"],
        percent: json["percent"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "percent": percent,
        "amount": amount,
      };
}
