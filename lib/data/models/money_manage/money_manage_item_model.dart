import 'package:fintch/gen_export.dart';

class MoneyManageItemModel {
  MoneyManageItemModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  MoneyManageItemData data;

  factory MoneyManageItemModel.fromJson(Map<String, dynamic> json) =>
      MoneyManageItemModel(
        message: json["message"],
        details: json["details"],
        data: MoneyManageItemData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
