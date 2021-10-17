import 'package:fintch/gen_export.dart';

class BarcodeModel {
  BarcodeModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  BarcodeData data;

  factory BarcodeModel.fromJson(Map<String, dynamic> json) => BarcodeModel(
        message: json["message"],
        details: json["details"],
        data: BarcodeData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
