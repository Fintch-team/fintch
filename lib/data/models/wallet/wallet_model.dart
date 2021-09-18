// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) => WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
    WalletModel({
        required this.data,
    });

    WalletData data;

    factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        data: WalletData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class WalletData {
    WalletData({
        required this.id,
        required this.walletAmount,
        required this.barrierAmount,
        required this.barrierExpired,
        required this.payAmount,
    });

    int id;
    int walletAmount;
    int barrierAmount;
    DateTime barrierExpired;
    int payAmount;

    factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json["id"],
        walletAmount: json["wallet_amount"],
        barrierAmount: json["barrier_amount"],
        barrierExpired: DateTime.parse(json["barrier_expired"]),
        payAmount: json["pay_amount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_amount": walletAmount,
        "barrier_amount": barrierAmount,
        "barrier_expired": "${barrierExpired.year.toString().padLeft(4, '0')}-${barrierExpired.month.toString().padLeft(2, '0')}-${barrierExpired.day.toString().padLeft(2, '0')}",
        "pay_amount": payAmount,
    };
}
