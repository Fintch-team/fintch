// To parse this JSON data, do
//
//     final moneyPlanModel = moneyPlanModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

MoneyPlanModel moneyPlanModelFromJson(String str) =>
    MoneyPlanModel.fromJson(json.decode(str));

String moneyPlanModelToJson(MoneyPlanModel data) => json.encode(data.toJson());

class MoneyPlanModel {
  MoneyPlanModel({
    required this.data,
  });

  MoneyPlanData data;

  factory MoneyPlanModel.fromJson(Map<String, dynamic> json) => MoneyPlanModel(
        data: MoneyPlanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class MoneyPlanData {
  MoneyPlanData({
    required this.id,
    required this.deadline,
    required this.note,
    required this.created,
    required this.user,
    required this.totalAmount,
  });

  int id;
  DateTime deadline;
  String note;
  DateTime created;
  User user;
  int totalAmount;

  factory MoneyPlanData.fromJson(Map<String, dynamic> json) => MoneyPlanData(
        id: json["id"],
        deadline: DateTime.parse(json["deadline"]),
        note: json["note"],
        created: DateTime.parse(json["created"]),
        user: User.fromJson(json["user"]),
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "note": note,
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "user": user.toJson(),
        "total_amount": totalAmount,
      };
}

