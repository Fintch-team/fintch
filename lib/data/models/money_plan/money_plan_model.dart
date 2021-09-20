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
    required this.response,
  });

  ResponseGlobal? response;
  MoneyPlanData data;

  factory MoneyPlanModel.fromJson(Map<String, dynamic> json) => MoneyPlanModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: MoneyPlanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
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
  DateTime? deadline;
  String note;
  DateTime? created;
  User user;
  int totalAmount;

  factory MoneyPlanData.fromJson(Map<String, dynamic> json) => MoneyPlanData(
        id: json["id"],
        deadline:
            json["deadline"] != null ? DateTime.parse(json["deadline"]) : null,
        note: json["note"],
        created:
            json["created"] != null ? DateTime.parse(json["created"]) : null,
        user: User.fromJson(json["user"]),
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deadline":
            "${deadline!.year.toString().padLeft(4, '0')}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}",
        "note": note,
        "created":
            "${created!.year.toString().padLeft(4, '0')}-${created!.month.toString().padLeft(2, '0')}-${created!.day.toString().padLeft(2, '0')}",
        "user": user.toJson(),
        "total_amount": totalAmount,
      };
}
