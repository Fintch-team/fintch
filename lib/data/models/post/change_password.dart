import 'dart:convert';
// To parse this JSON data, do
//
//     final postChangePassword = postChangePasswordFromJson(jsonString);

PostChangePassword postChangePasswordFromJson(String str) => PostChangePassword.fromJson(json.decode(str));

String postChangePasswordToJson(PostChangePassword data) => json.encode(data.toJson());

class PostChangePassword {
  PostChangePassword({
    required this.nickname,
    required this.password,
    required this.passwordOld,
  });

  String nickname;
  String password;
  String passwordOld;

  factory PostChangePassword.fromJson(Map<String, dynamic> json) => PostChangePassword(
    nickname: json["nickname"],
    password: json["password"],
    passwordOld: json["password_old"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname,
    "password": password,
    "password_old": passwordOld,
  };
}
