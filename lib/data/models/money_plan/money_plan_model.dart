import 'package:fintch/gen_export.dart';

class MoneyPlanModel {
  MoneyPlanModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  MoneyPlanData data;

  factory MoneyPlanModel.fromJson(Map<String, dynamic> json) => MoneyPlanModel(
        message: json["message"],
        details: json["details"],
        data: MoneyPlanData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
