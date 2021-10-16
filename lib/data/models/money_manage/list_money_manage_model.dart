import 'package:fintch/gen_export.dart';

class ListMoneyManageModel {
  ListMoneyManageModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<MoneyManageData> data;
  Meta meta;

  factory ListMoneyManageModel.fromJson(Map<String, dynamic> json) =>
      ListMoneyManageModel(
        message: json["message"],
        details: json["details"],
        data: List<MoneyManageData>.from(
            json["data"].map((x) => MoneyManageData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
