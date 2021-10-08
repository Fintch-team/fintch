import 'package:fintch/gen_export.dart';

class ListMoneyPlanModel {
  ListMoneyPlanModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<MoneyPlanData> data;
  Meta meta;

  factory ListMoneyPlanModel.fromJson(Map<String, dynamic> json) =>
      ListMoneyPlanModel(
        message: json["message"],
        details: json["details"],
        data: List<MoneyPlanData>.from(
            json["data"].map((x) => MoneyPlanData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
