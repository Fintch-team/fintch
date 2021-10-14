import 'package:fintch/gen_export.dart';

class MoneyManageIncomeModel {
  MoneyManageIncomeModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  IncomeData data;

  factory MoneyManageIncomeModel.fromJson(Map<String, dynamic> json) =>
      MoneyManageIncomeModel(
        message: json["message"],
        details: json["details"],
        data: IncomeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}

class IncomeData {
  IncomeData({
    required this.income,
    required this.outcome,
  });

  int income;
  int outcome;

  factory IncomeData.fromJson(Map<String, dynamic> json) => IncomeData(
        income: json["income"],
        outcome: json["outcome"],
      );

  Map<String, dynamic> toJson() => {
        "income": income,
        "outcome": outcome,
      };
}
