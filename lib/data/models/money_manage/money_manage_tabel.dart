class MoneyManageTabelModel {
  MoneyManageTabelModel({
    required this.message,
    required this.details,
    required this.data,
  });

  String message;
  dynamic details;
  TabelData data;

  factory MoneyManageTabelModel.fromJson(Map<String, dynamic> json) =>
      MoneyManageTabelModel(
        message: json["message"],
        details: json["details"],
        data: TabelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "details": details,
        "data": data.toJson(),
      };
}

class TabelData {
  TabelData({
    required this.income,
    required this.outcome,
  });

  Tabel income;
  Tabel outcome;

  factory TabelData.fromJson(Map<String, dynamic> json) => TabelData(
        income: Tabel.fromJson(json["income"]),
        outcome: Tabel.fromJson(json["outcome"]),
      );

  Map<String, dynamic> toJson() => {
        "income": income.toJson(),
        "outcome": outcome.toJson(),
      };
}

class Tabel {
  Tabel({
    required this.fri,
    required this.sat,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
  });

  int fri;
  int sat;
  int sun;
  int mon;
  int tue;
  int wed;
  int thu;

  factory Tabel.fromJson(Map<String, dynamic> json) => Tabel(
        fri: json["Fri"],
        sat: json["Sat"],
        sun: json["Sun"],
        mon: json["Mon"],
        tue: json["Tue"],
        wed: json["Wed"],
        thu: json["Thu"],
      );

  Map<String, dynamic> toJson() => {
        "Fri": fri,
        "Sat": sat,
        "Sun": sun,
        "Mon": mon,
        "Tue": tue,
        "Wed": wed,
        "Thu": thu,
      };
}
