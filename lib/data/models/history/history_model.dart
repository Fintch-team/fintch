// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    required this.data,
  });

  HistoryData data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data: HistoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class HistoryData {
  HistoryData({
    required this.id,
    required this.amount,
    required this.pay,
    required this.receive,
  });

  int id;
  String amount;
  Pay pay;
  Pay receive;

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        id: json["id"],
        amount: json["amount"],
        pay: Pay.fromJson(json["pay"]),
        receive: Pay.fromJson(json["receive"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "pay": pay.toJson(),
        "receive": receive.toJson(),
      };
}


