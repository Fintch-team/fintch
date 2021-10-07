import 'package:fintch/gen_export.dart';
import 'package:flutter/widgets.dart';

class MoneyPlanPostEntity extends BaseEntity {
  final int idUser;
  final int totalAmount;
  final DateTime deadline;

  MoneyPlanPostEntity(
      {required this.idUser,
      required this.totalAmount,
      required this.deadline});
}

class MoneyPlanPutEntity extends BaseEntity {
  final String idMoneyPlan;
  final int idUser;
  final int totalAmount;
  final DateTime deadline;

  MoneyPlanPutEntity(
      {required this.idMoneyPlan,
      required this.idUser,
      required this.totalAmount,
      required this.deadline});
}

class MoneyPlanEntity extends BaseEntity {
  final int id;
  final DateTime? deadline;
  final User user;
  final int totalAmount;
  final String note;
  final DateTime? created;

  MoneyPlanEntity(
      {required this.id,
      required this.deadline,
      required this.user,
      required this.totalAmount,
      required this.note,
      required this.created});
}
