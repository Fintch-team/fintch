import 'package:fintch/gen_export.dart';

class HistoryPostEntity extends BaseEntity {
  final String idPay;
  final String idReceive;
  final int amount;

  HistoryPostEntity(
      {required this.idPay, required this.idReceive, required this.amount});
}

class HistoryPutEntity extends BaseEntity {
  final String idPay;
  final String idHistory;
  final String idReceive;
  final int amount;

  HistoryPutEntity(
      {required this.idPay,
      required this.idReceive,
      required this.idHistory,
      required this.amount});
}

class HistoryEntity extends BaseEntity {
  final List<HistoryData> pay;
  final List<HistoryData> receive;

  HistoryEntity({required this.pay, required this.receive});
}
