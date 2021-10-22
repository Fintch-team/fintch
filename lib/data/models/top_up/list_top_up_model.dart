import 'package:fintch/gen_export.dart';

class ListTopUpModel {
  ListTopUpModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<TopUpData> data;
  Meta meta;

  factory ListTopUpModel.fromJson(Map<String, dynamic> json) => ListTopUpModel(
        message: json["message"],
        details: json["details"],
        data: List<TopUpData>.from(
            json["data"].map((x) => TopUpData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
