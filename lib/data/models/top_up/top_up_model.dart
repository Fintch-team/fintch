import 'package:fintch/gen_export.dart';

class TopUpModel {
  TopUpModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  TopUpData data;

  factory TopUpModel.fromJson(Map<String, dynamic> json) => TopUpModel(
        message: json["message"],
        details: json["details"],
        data: TopUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
