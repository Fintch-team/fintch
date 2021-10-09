import 'package:fintch/gen_export.dart';

class ListHistoryModel {
  ListHistoryModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<HistoryData> data;
  Meta meta;

  factory ListHistoryModel.fromJson(Map<String, dynamic> json) =>
      ListHistoryModel(
        message: json["message"],
        details: json["details"],
        data: List<HistoryData>.from(
            json["data"].map((x) => HistoryData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
