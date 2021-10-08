class MoneyPlanData {
  MoneyPlanData({
    required this.id,
    required this.name,
    required this.deadline,
    required this.note,
    required this.percent,
    required this.created,
    required this.amount,
    required this.totalAmount,
  });

  int id;
  String name;
  DateTime? deadline;
  String note;
  int percent;
  DateTime created;
  int amount;
  int totalAmount;

  factory MoneyPlanData.fromJson(Map<String, dynamic> json) => MoneyPlanData(
        id: json["id"],
        name: json["name"],
        deadline: DateTime.parse(json["deadline"]),
        note: json["note"],
        percent: json["percent"],
        created: DateTime.parse(json["created"]),
        amount: json["amount"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deadline":
            "${deadline!.year.toString().padLeft(4, '0')}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}",
        "note": note,
        "percent": percent,
        "created":
            "${created.year.toString().padLeft(4, '0')}-${created.month.toString().padLeft(2, '0')}-${created.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "total_amount": totalAmount,
      };
}
