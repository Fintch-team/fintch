// To parse this JSON data, do
//
//     final listMoneyManageItemModel = listMoneyManageItemModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListMoneyManageItemModel listMoneyManageItemModelFromJson(String str) =>
    ListMoneyManageItemModel.fromJson(json.decode(str));

String listMoneyManageItemModelToJson(ListMoneyManageItemModel data) =>
    json.encode(data.toJson());

class ListMoneyManageItemModel {
  ListMoneyManageItemModel({
    required this.data,
    required this.meta,
  });

  List<MoneyManageItemData> data;
  Meta meta;

  factory ListMoneyManageItemModel.fromJson(Map<String, dynamic> json) =>
      ListMoneyManageItemModel(
        data: List<MoneyManageItemData>.from(
            json["data"].map((x) => MoneyManageItemData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
