import 'package:fintch/gen_export.dart';

class TokenModel {
  TokenModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  Data data;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        message: json["message"],
        details: json["details"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  UserData user;
  String accessToken;
  String tokenType;
  DateTime expiresIn;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: UserData.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: DateTime.parse(json["expires_in"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn.toIso8601String(),
      };
}
