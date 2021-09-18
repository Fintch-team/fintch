// To parse this JSON data, do
//
//     final listWalletModel = listWalletModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

ListWalletModel listWalletModelFromJson(String str) => ListWalletModel.fromJson(json.decode(str));

String listWalletModelToJson(ListWalletModel data) => json.encode(data.toJson());

class ListWalletModel {
    ListWalletModel({
        required this.data,
        required this.meta,
    });

    List<WalletData> data;
    Meta meta;

    factory ListWalletModel.fromJson(Map<String, dynamic> json) => ListWalletModel(
        data: List<WalletData>.from(json["data"].map((x) => WalletData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
    };
}
