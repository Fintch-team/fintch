// To parse this JSON data, do
//
//     final moneyManageItemModel = moneyManageItemModelFromJson(jsonString);

import 'dart:convert';

MoneyManageItemModel moneyManageItemModelFromJson(String str) => MoneyManageItemModel.fromJson(json.decode(str));

String moneyManageItemModelToJson(MoneyManageItemModel data) => json.encode(data.toJson());

class MoneyManageItemModel {
    MoneyManageItemModel({
        required this.data,
    });

    MoneyManageItemData data;

    factory MoneyManageItemModel.fromJson(Map<String, dynamic> json) => MoneyManageItemModel(
        data: MoneyManageItemData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

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

    factory MoneyManageItemData.fromJson(Map<String, dynamic> json) => MoneyManageItemData(
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
