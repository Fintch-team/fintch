import 'package:fintch/gen_export.dart';

class SchoolModel {
  SchoolModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  SchoolData data;

  factory SchoolModel.fromJson(Map<String, dynamic> json) => SchoolModel(
        message: json["message"],
        details: json["details"],
        data: SchoolData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
