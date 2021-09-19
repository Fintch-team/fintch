// To parse this JSON data, do
//
//     final moneyManageModel = moneyManageModelFromJson(jsonString);

import 'dart:convert';

MoneyManageModel moneyManageModelFromJson(String str) => MoneyManageModel.fromJson(json.decode(str));

String moneyManageModelToJson(MoneyManageModel data) => json.encode(data.toJson());

class MoneyManageModel {
    MoneyManageModel({
        required this.data,
    });

    MoneyManageData data;

    factory MoneyManageModel.fromJson(Map<String, dynamic> json) => MoneyManageModel(
        data: MoneyManageData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

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
    Item item;

    factory MoneyManageData.fromJson(Map<String, dynamic> json) => MoneyManageData(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        isIncome: json["is_income"],
        item: Item.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "is_income": isIncome,
        "item": item.toJson(),
    };
}

class Item {
    Item({
        required this.id,
        required this.name,
        required this.percent,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String name;
    int percent;
    int amount;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        percent: json["percent"],
        amount: json["amount"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "percent": percent,
        "amount": amount,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
