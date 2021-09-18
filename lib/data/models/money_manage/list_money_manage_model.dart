// To parse this JSON data, do
//
//     final listMoneyManageModel = listMoneyManageModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListMoneyManageModel listMoneyManageModelFromJson(String str) => ListMoneyManageModel.fromJson(json.decode(str));

String listMoneyManageModelToJson(ListMoneyManageModel data) => json.encode(data.toJson());

class ListMoneyManageModel {
    ListMoneyManageModel({
        required this.data,
        required this.meta,
    });

    List<MoneyManageData> data;
    Meta meta;

    factory ListMoneyManageModel.fromJson(Map<String, dynamic> json) => ListMoneyManageModel(
        data: List<MoneyManageData>.from(json["data"].map((x) => MoneyManageData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}
