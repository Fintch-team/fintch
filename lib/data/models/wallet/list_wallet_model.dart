import 'package:fintch/gen_export.dart';

class ListWalletModel {
  ListWalletModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<WalletData> data;
  Meta meta;

  factory ListWalletModel.fromJson(Map<String, dynamic> json) =>
      ListWalletModel(
        message: json["message"],
        details: json["details"],
        data: List<WalletData>.from(
            json["data"].map((x) => WalletData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
