import 'package:fintch/gen_export.dart';

class TopUpModel {
  TopUpModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  TopUpData data;

  factory TopUpModel.fromJson(Map<String, dynamic> json) => TopUpModel(
        message: json["message"],
        details: json["details"],
        data: TopUpData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}

class TopUpData {
  TopUpData({
    required this.user,
    required this.token,
    required this.webUrl,
  });

  UserData user;
  String token;
  String webUrl;

  factory TopUpData.fromJson(Map<String, dynamic> json) => TopUpData(
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
