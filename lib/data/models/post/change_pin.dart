// To parse this JSON data, do
//
//     final postChangePin = postChangePinFromJson(jsonString);

import 'dart:convert';

PostChangePin postChangePinFromJson(String str) => PostChangePin.fromJson(json.decode(str));

String postChangePinToJson(PostChangePin data) => json.encode(data.toJson());

class PostChangePin {
  PostChangePin({
    required this.nickname,
    required this.pin,
    required this.password,
  });

  String nickname;
  String pin;
  String password;

  factory PostChangePin.fromJson(Map<String, dynamic> json) => PostChangePin(
    nickname: json["nickname"],
    pin: json["pin"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "pin": pin,
    "password": password,
  };
}
