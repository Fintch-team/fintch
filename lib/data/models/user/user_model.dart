// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.data,
    required this.message,
  });

  String? message;
  DataUser data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        data: DataUser.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataUser {
  DataUser({
    required this.id,
    required this.name,
    required this.nickname,
    required this.img,
    required this.isSetPass,
    required this.isSetPin,
    required this.wallet,
    required this.school,
    required this.pay,
    required this.receive,
    required this.moneyPlanning,
  });

  int id;
  String name;
  String nickname;
  String img;
  bool isSetPass;
  bool isSetPin;
  Wallet? wallet;
  Datum? school;
  List<Datum> pay;
  List<Datum> receive;
  List<MoneyPlanning> moneyPlanning;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        name: json["name"],
        nickname: json["nickname"],
        img: json["img"],
        wallet: Wallet.fromJson(json["wallet"]),
        isSetPass: json["is_set_pass"],
        isSetPin: json["is_set_pin"],
        school: Datum.fromJson(json["school"]),
        pay: List<Datum>.from(json["pay"].map((x) => Datum.fromJson(x))),
        receive:
            List<Datum>.from(json["receive"].map((x) => Datum.fromJson(x))),
        moneyPlanning: List<MoneyPlanning>.from(
            json["money_planning"].map((x) => MoneyPlanning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nickname": nickname,
        "img": img,
        "wallet": wallet!.toJson(),
        "is_set_pass": isSetPass,
        "is_set_pin": isSetPin,
        "school": school!.toJson(),
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "receive": List<dynamic>.from(receive.map((x) => x.toJson())),
        "money_planning":
            List<dynamic>.from(moneyPlanning.map((x) => x.toJson())),
      };
}

class MoneyPlanning {
  MoneyPlanning({
    required this.id,
    required this.deadline,
    required this.idUser,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  DateTime deadline;
  int idUser;
  int totalAmount;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory MoneyPlanning.fromJson(Map<String, dynamic> json) => MoneyPlanning(
        id: json["id"],
        deadline: DateTime.parse(json["deadline"]),
        idUser: json["id_user"],
        totalAmount: json["total_amount"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "id_user": idUser,
        "total_amount": totalAmount,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  int id;
  String? amount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        amount: json["amount"] == null ? null : json["amount"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "name": name,
      };
}

class Wallet {
  Wallet({
    required this.id,
    required this.walletAmount,
    required this.barrierAmount,
    required this.payAmount,
    required this.barrierExpired,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int walletAmount;
  int barrierAmount;
  int payAmount;
  DateTime? barrierExpired;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        walletAmount: json["wallet_amount"],
        barrierAmount: json["barrier_amount"],
        payAmount: json["pay_amount"],
        barrierExpired: json["barrier_expired"] != null
            ? DateTime.parse(json["barrier_expired"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_amount": walletAmount,
        "barrier_amount": barrierAmount,
        "pay_amount": payAmount,
        "barrier_expired": barrierExpired != null
            ? "${barrierExpired!.year.toString().padLeft(4, '0')}-${barrierExpired!.month.toString().padLeft(2, '0')}-${barrierExpired!.day.toString().padLeft(2, '0')}"
            : null,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
      };
}

// import 'package:json_annotation/json_annotation.dart';
// part 'user_model.g.dart';

// @JsonSerializable()
// class User {
//   String name, lastName, add;
//   bool subscription;

//   User({
//     required this.name,
//     required this.lastName,
//     required this.add,
//     required this.subscription,
//   });

//   factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

//   Map<String, dynamic> toJson() => _$UserToJson(this);
// }
