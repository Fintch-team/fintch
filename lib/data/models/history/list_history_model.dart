import 'package:fintch/gen_export.dart';

class ListHistoryModel {
  ListHistoryModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String? message;
  dynamic details;
  DataHistory? data;

  factory ListHistoryModel.fromJson(Map<String, dynamic> json) =>
      ListHistoryModel(
        message: json["message"],
        details: json["details"],
        data: json['data'] != null ? DataHistory.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data != null ? data?.toJson() : null,
      };
}

class DataHistory {
  DataHistory({
    this.pay,
    this.receive,
  });

  List<HistoryData>? pay;
  List<HistoryData>? receive;

  factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
    pay: List<HistoryData>.from(json["pay"].map((x) => HistoryData.fromJson(x))),
    receive: List<HistoryData>.from(json["receive"].map((x) => HistoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pay": pay?.map((v) => v.toJson()).toList(),
    "receive": receive?.map((v) => v.toJson()).toList(),
  };
}
