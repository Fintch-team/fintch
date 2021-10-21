import 'package:fintch/gen_export.dart';

class WalletData {
  WalletData({
    required this.id,
    required this.walletAmount,
    required this.barrierAmount,
    required this.payAmount,
    required this.barrierExpired,
    required this.user,
  });

  int id;
  int walletAmount;
  int barrierAmount;
  int payAmount;
  DateTime? barrierExpired;
  UserMini? user;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json["id"],
        walletAmount: json["wallet_amount"],
        barrierAmount: json["barrier_amount"],
        payAmount: json["pay_amount"],
        barrierExpired: json["barrier_expired"] == null
            ? null
            : DateTime.parse(json["barrier_expired"]),
        user: json["user"] == null ? null : UserMini.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_amount": walletAmount,
        "barrier_amount": barrierAmount,
        "pay_amount": payAmount,
        "user": user == null ? null : user!.toJson(),
        "barrier_expired": barrierExpired == null
            ? null
            : "${barrierExpired!.year.toString().padLeft(4, '0')}-${barrierExpired!.month.toString().padLeft(2, '0')}-${barrierExpired!.day.toString().padLeft(2, '0')}",
      };
}
