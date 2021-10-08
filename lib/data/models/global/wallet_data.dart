class WalletData {
  WalletData({
    required this.id,
    required this.walletAmount,
    required this.barrierAmount,
    required this.payAmount,
    required this.barrierExpired,
  });

  int id;
  int walletAmount;
  int barrierAmount;
  int payAmount;
  DateTime barrierExpired;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        id: json["id"],
        walletAmount: json["wallet_amount"],
        barrierAmount: json["barrier_amount"],
        payAmount: json["pay_amount"],
        barrierExpired: DateTime.parse(json["barrier_expired"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wallet_amount": walletAmount,
        "barrier_amount": barrierAmount,
        "pay_amount": payAmount,
        "barrier_expired":
            "${barrierExpired.year.toString().padLeft(4, '0')}-${barrierExpired.month.toString().padLeft(2, '0')}-${barrierExpired.day.toString().padLeft(2, '0')}",
      };
}
