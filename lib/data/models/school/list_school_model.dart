// To parse this JSON data, do
//
//     final listSchoolModel = listSchoolModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListSchoolModel listSchoolModelFromJson(String str) =>
    ListSchoolModel.fromJson(json.decode(str));

String listSchoolModelToJson(ListSchoolModel data) =>
    json.encode(data.toJson());

class ListSchoolModel {
  ListSchoolModel({
    required this.data,
    required this.meta,
    required this.response,
  });

  ResponseGlobal? response;
  List<SchoolData> data;
  Meta meta;

  factory ListSchoolModel.fromJson(Map<String, dynamic> json) =>
      ListSchoolModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: List<SchoolData>.from(
            json["data"].map((x) => SchoolData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
