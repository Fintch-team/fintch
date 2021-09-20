// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

import 'package:fintch/gen_export.dart';

TokenModel tokenModelFromJson(String str) =>
    TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  TokenModel({
    required this.data,
    required this.response,
  });

  ResponseGlobal? response;
  Data data;

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        response: ResponseGlobal.fromJson(json["response"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response!.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  String accessToken;
  String tokenType;
  int expiresIn;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
