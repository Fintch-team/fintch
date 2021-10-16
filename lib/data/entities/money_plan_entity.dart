import 'package:fintch/gen_export.dart';

class MoneyPlanPostEntity extends BaseEntity {
  final String name;
  final String totalAmount;
  final String deadline;

  MoneyPlanPostEntity(
      {required this.name, required this.totalAmount, required this.deadline});
}

class MoneyPlanPutEntity extends BaseEntity {
  final String idMoneyPlan;
  final String totalAmount;
  final String deadline;
  final String name;

  MoneyPlanPutEntity(
      {required this.idMoneyPlan,
      required this.name,
      required this.totalAmount,
      required this.deadline});
}

class MoneyPlanEntity extends BaseEntity {
  final int id;
  final DateTime? deadline;
  final int totalAmount;
  final int amount;
  final String note;
  final String name;
  final int percent;
  final DateTime? created;

  MoneyPlanEntity(
      {required this.id,
      required this.deadline,
      required this.totalAmount,
      required this.amount,
      required this.note,
      required this.name,
      required this.percent,
      required this.created});
}

class ListMoneyPlanEntity extends BaseEntity {
  final List<MoneyPlanData> data;

  ListMoneyPlanEntity({
    required this.data,
  });
}
