import 'package:fintch/gen_export.dart';

class TopUpData {
  TopUpData({
    required this.id,
    required this.number,
    required this.name,
    required this.totalPrice,
    required this.paymentStatus,
    required this.snapToken,
    required this.redirectUrl,
    required this.createdAt,
    required this.user,
  });

  int id;
  String number;
  String name;
  String totalPrice;
  String paymentStatus;
  String snapToken;
  String redirectUrl;
  DateTime createdAt;
  UserMini user;

  factory TopUpData.fromJson(Map<String, dynamic> json) => TopUpData(
        id: json["id"],
        number: json["number"],
        name: json["name"],
        totalPrice: json["total_price"],
        paymentStatus: json["payment_status"],
        snapToken: json["snap_token"],
        redirectUrl: json["redirect_url"],
        createdAt: DateTime.parse(json["created_at"]),
        user: UserMini.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "name": name,
        "total_price": totalPrice,
        "payment_status": paymentStatus,
        "snap_token": snapToken,
        "redirect_url": redirectUrl,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
      };
}
