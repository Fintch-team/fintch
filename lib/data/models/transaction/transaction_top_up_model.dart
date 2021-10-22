import 'package:fintch/gen_export.dart';

class TransactionTopUpModel {
  TransactionTopUpModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  TransactionTopUpData data;

  factory TransactionTopUpModel.fromJson(Map<String, dynamic> json) =>
      TransactionTopUpModel(
        message: json["message"],
        details: json["details"],
        data: TransactionTopUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}

class TransactionTopUpData {
  TransactionTopUpData({
    required this.user,
    required this.token,
    required this.webUrl,
  });

  UserData user;
  String token;
  String webUrl;

  factory TransactionTopUpData.fromJson(Map<String, dynamic> json) =>
      TransactionTopUpData(
        user: UserData.fromJson(json["user"]),
        token: json["token"],
        webUrl: json["redirect_url"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": token,
        "token_type": webUrl,
      };
}
