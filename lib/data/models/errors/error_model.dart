// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
    ErrorModel({
        required this.error,
    });

    Error error;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: Error.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error.toJson(),
    };
}

class Error {
    Error({
        required this.message,
        required this.status,
    });

    String message;
    int status;

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
