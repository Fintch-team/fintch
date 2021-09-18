// To parse this JSON data, do
//
//     final listUserModel = listUserModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListUserModel listUserModelFromJson(String str) => ListUserModel.fromJson(json.decode(str));

String listUserModelToJson(ListUserModel data) => json.encode(data.toJson());

class ListUserModel {
    ListUserModel({
        required this.data,
        required this.meta,
    });

    List<DataUser> data;
    Meta meta;

    factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
        data: List<DataUser>.from(json["data"].map((x) => DataUser.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}
