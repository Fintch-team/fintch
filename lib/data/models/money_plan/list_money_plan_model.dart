// To parse this JSON data, do
//
//     final listMoneyPlanModel = listMoneyPlanModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListMoneyPlanModel listMoneyPlanModelFromJson(String str) =>
    ListMoneyPlanModel.fromJson(json.decode(str));

String listMoneyPlanModelToJson(ListMoneyPlanModel data) =>
    json.encode(data.toJson());

class ListMoneyPlanModel {
  ListMoneyPlanModel({
    required this.data,
    required this.meta,
    required this.response,
  });

  ResponseGlobal? response;
  List<MoneyPlanData> data;
  Meta meta;

  factory ListMoneyPlanModel.fromJson(Map<String, dynamic> json) =>
      ListMoneyPlanModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: List<MoneyPlanData>.from(
            json["data"].map((x) => MoneyPlanData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
