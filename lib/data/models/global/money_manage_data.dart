import 'package:fintch/gen_export.dart';


class MoneyManageData {
  MoneyManageData({
    required this.id,
    required this.name,
    required this.amount,
    required this.isIncome,
    required this.item,
  });

  int id;
  String name;
  int amount;
  bool isIncome;
  MoneyManageItemData item;

  factory MoneyManageData.fromJson(Map<String, dynamic> json) =>
      MoneyManageData(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        isIncome: json["is_income"],
        item: MoneyManageItemData.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "is_income": isIncome,
        "item": item.toJson(),
      };
}
