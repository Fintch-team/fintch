import 'package:fintch/gen_export.dart';

class ListUserModel {
  ListUserModel({
    required this.message,
    required this.details,
    required this.data,
    required this.meta,
  });

  String message;
  dynamic details;
  List<UserData> data;
  Meta meta;

  factory ListUserModel.fromJson(Map<String, dynamic> json) => ListUserModel(
        message: json["message"],
        details: json["details"],
        data:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}
