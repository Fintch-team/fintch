import 'package:fintch/gen_export.dart';

class UserModel {
  UserModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  UserData data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        details: json["details"],
        data: UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}
