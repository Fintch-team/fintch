import 'package:fintch/gen_export.dart';

class ListHistoryModel {
  ListHistoryModel({
    required this.message,
    required this.details,
    required this.data,
    // required this.meta,

  });

  String? message;
  dynamic details;
  HistoryFormat data;
  // Meta meta;


  factory ListHistoryModel.fromJson(Map<String, dynamic> json) =>
      ListHistoryModel(
        message: json["message"],
        details: json["details"],
        data: HistoryFormat.fromJson(json["data"]),
        // meta: Meta.fromJson(json["meta"]),

      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
        // "meta": meta.toJson(),
      };
}

class HistoryFormat {
  HistoryFormat({
    required this.pay,
    required this.receive,
  });

  List<HistoryData> pay;
  List<HistoryData> receive;

  factory HistoryFormat.fromJson(Map<String, dynamic> json) => HistoryFormat(
        pay: List<HistoryData>.from(
            json["pay"].map((x) => HistoryData.fromJson(x))),
        receive: List<HistoryData>.from(
            json["receive"].map((x) => HistoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "receive": List<dynamic>.from(receive.map((x) => x.toJson())),

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
