// To parse this JSON data, do
//
//     final moneyManageitemModel = moneyManageitemModelFromJson(jsonString);

import 'dart:convert';

MoneyManageitemModel moneyManageitemModelFromJson(String str) => MoneyManageitemModel.fromJson(json.decode(str));

String moneyManageitemModelToJson(MoneyManageitemModel data) => json.encode(data.toJson());

class MoneyManageitemModel {
    MoneyManageitemModel({
        required this.data,
    });

    MoneyManageItemData data;

    factory MoneyManageitemModel.fromJson(Map<String, dynamic> json) => MoneyManageitemModel(
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
