import 'package:fintch/gen_export.dart';

class TransactionData {
  TransactionData({
    required this.amount,
    required this.pay,
    required this.receive,
  });

  String amount;
  WalletData pay;
  WalletData receive;

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      TransactionData(
        amount: json["amount"],
        pay: WalletData.fromJson(json["pay"]),
        receive: WalletData.fromJson(json["receive"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "pay": pay.toJson(),
        "receive": receive.toJson(),
      };
}
