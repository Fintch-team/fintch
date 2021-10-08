import 'package:fintch/gen_export.dart';

class ListMoneyManageItemModel {
  ListMoneyManageItemModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<MoneyManageItemData> data;
  Meta meta;

  factory ListMoneyManageItemModel.fromJson(Map<String, dynamic> json) =>
      ListMoneyManageItemModel(
        message: json["message"],
        details: json["details"],
        data: List<MoneyManageItemData>.from(
            json["data"].map((x) => MoneyManageItemData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
