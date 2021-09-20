// To parse this JSON data, do
//
//     final listHistoryModel = listHistoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListHistoryModel listHistoryModelFromJson(String str) =>
    ListHistoryModel.fromJson(json.decode(str));

String listHistoryModelToJson(ListHistoryModel data) =>
    json.encode(data.toJson());

class ListHistoryModel {
  ListHistoryModel({
    required this.data,
    required this.meta,
    required this.response,
  });

  ResponseGlobal? response;
  List<HistoryData> data;
  Meta meta;

  factory ListHistoryModel.fromJson(Map<String, dynamic> json) =>
      ListHistoryModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: List<HistoryData>.from(
            json["data"].map((x) => HistoryData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
