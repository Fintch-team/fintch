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
  });

  SchoolData data;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        data: SchoolData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
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

