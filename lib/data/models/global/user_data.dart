import 'package:fintch/gen_export.dart';

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.nickname,
    required this.img,
    required this.isSetPass,
    required this.level,
    required this.isSetPin,
    required this.wallet,
    required this.school,
    required this.pay,
    required this.barcode,
    required this.receive,
    required this.moneyPlanning,
    required this.moneyManage,
  });

  int id;
  String name;
  String nickname;
  String img;
  String level;
  bool isSetPass;
  bool isSetPin;
  WalletData wallet;
  SchoolData school;
  List<HistoryData> pay;
  List<HistoryData> receive;
  List<BarcodeData> barcode;
  List<MoneyPlanData> moneyPlanning;
  List<MoneyManageData> moneyManage;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        nickname: json["nickname"],
        img: json["img"],
        isSetPass: json["is_set_pass"],
        isSetPin: json["is_set_pin"],
        level: json["level"],
        wallet: WalletData.fromJson(json["wallet"]),
        school: SchoolData.fromJson(json["school"]),
        barcode: List<BarcodeData>.from(
            json["barcode"].map((x) => BarcodeData.fromJson(x))),
        pay: List<HistoryData>.from(
            json["pay"].map((x) => HistoryData.fromJson(x))),
        receive: List<HistoryData>.from(
            json["receive"].map((x) => HistoryData.fromJson(x))),
        moneyPlanning: List<MoneyPlanData>.from(
            json["money_planning"].map((x) => MoneyPlanData.fromJson(x))),
        moneyManage: List<MoneyManageData>.from(
            json["money_manage"].map((x) => MoneyManageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nickname": nickname,
        "level": level,
        "img": img,
        "is_set_pass": isSetPass,
        "is_set_pin": isSetPin,
        "wallet": wallet.toJson(),
        "school": school.toJson(),
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "barcode": List<dynamic>.from(barcode.map((x) => x.toJson())),
        "receive": List<dynamic>.from(receive.map((x) => x.toJson())),
        "money_planning":
            List<dynamic>.from(moneyPlanning.map((x) => x.toJson())),
        "money_manage": List<dynamic>.from(moneyManage.map((x) => x.toJson())),
      };
}
