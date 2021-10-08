import 'package:fintch/gen_export.dart';

class MoneyManageModel {
  MoneyManageModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  MoneyManageData data;

  factory MoneyManageModel.fromJson(Map<String, dynamic> json) =>
      MoneyManageModel(
        message: json["message"],
        details: json["details"],
        data: MoneyManageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
