import 'package:fintch/gen_export.dart';

class HistoryData {
  HistoryData({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.pay,
    required this.receive,
  });

  int id;
  String amount;
  DateTime createdAt;
  UserMini? pay;
  UserMini? receive;

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        id: json["id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
        pay: json["pay"] == null ? null : UserMini.fromJson(json["pay"]),
        receive:
            json["receive"] == null ? null : UserMini.fromJson(json["receive"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
        "pay": pay != null ? pay!.toJson() : null,
        "receive": receive != null ? receive!.toJson() : null,
      };
}

// class HistoryPay {
//   HistoryPay({
//     required this.id,
//     required this.amount,
//     required this.createdAt,
//     required this.pay,
//   });

//   int id;
//   String amount;
//   DateTime createdAt;
//   UserMini pay;

//   factory HistoryPay.fromJson(Map<String, dynamic> json) => HistoryPay(
//         id: json["id"],
//         amount: json["amount"],
//         createdAt: DateTime.parse(json["created_at"]),
//         pay: UserMini.fromJson(json["pay"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "amount": amount,
//         "created_at": createdAt.toIso8601String(),
//         "pay": pay.toJson(),
//       };
// }

// class HistoryReceive {
//   HistoryReceive({
//     required this.id,
//     required this.amount,
//     required this.createdAt,
//     required this.receive,
//   });

//   int id;
//   String amount;
//   DateTime createdAt;
//   UserMini receive;

//   factory HistoryReceive.fromJson(Map<String, dynamic> json) => HistoryReceive(
//         id: json["id"],
//         amount: json["amount"],
//         createdAt: DateTime.parse(json["created_at"]),
//         receive: UserMini.fromJson(json["receive"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "amount": amount,
//         "created_at": createdAt.toIso8601String(),
//         "receive": receive.toJson(),
//       };
// }
