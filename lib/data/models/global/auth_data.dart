import 'package:fintch/gen_export.dart';

class AuthData {
  AuthData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  UserData user;
  String accessToken;
  String tokenType;
  DateTime expiresIn;

  factory AuthData.fromJson(Map<String, dynamic> json) => AuthData(
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
