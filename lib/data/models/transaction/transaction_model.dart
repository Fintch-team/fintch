import 'package:fintch/gen_export.dart';

class TransactionModel {
  TransactionModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  TransactionData data;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        message: json["message"],
        details: json["details"],
        data: TransactionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
