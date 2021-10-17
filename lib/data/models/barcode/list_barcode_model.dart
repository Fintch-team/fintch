import 'package:fintch/gen_export.dart';

class ListBarcodeModel {
  ListBarcodeModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<BarcodeData> data;
  Meta meta;

  factory ListBarcodeModel.fromJson(Map<String, dynamic> json) =>
      ListBarcodeModel(
        message: json["message"],
        details: json["details"],
        data: List<BarcodeData>.from(
            json["data"].map((x) => BarcodeData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
