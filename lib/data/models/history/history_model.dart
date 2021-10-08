import 'package:fintch/gen_export.dart';

class HistoryModel {
  HistoryModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  HistoryData data;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        message: json["message"],
        details: json["details"],
        data: HistoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
