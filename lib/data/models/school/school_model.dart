// To parse this JSON data, do
//
//     final schoolModel = schoolModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

SchoolModel schoolModelFromJson(String str) =>
    SchoolModel.fromJson(json.decode(str));

String schoolModelToJson(SchoolModel data) => json.encode(data.toJson());

class SchoolModel {
  SchoolModel({
    required this.data,
    required this.response,
  });

  ResponseGlobal? response;
  SchoolData data;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: SchoolData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "data": data.toJson(),
      };
}

class SchoolData {
  SchoolData({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory SchoolData.fromJson(Map<String, dynamic> json) => SchoolData(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
