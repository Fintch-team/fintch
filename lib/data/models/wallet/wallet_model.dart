import 'package:fintch/gen_export.dart';

class WalletModel {
  WalletModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  WalletData data;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        message: json["message"],
        details: json["details"],
        data: WalletData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
