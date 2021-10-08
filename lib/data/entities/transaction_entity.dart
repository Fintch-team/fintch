import 'package:fintch/gen_export.dart';

class TransactionPostEntity extends BaseEntity {
  final int amount;
  final String idPay;
  final String idReceive;

  TransactionPostEntity({
    required this.amount,
    required this.idPay,
    required this.idReceive,
  });
}

class TransactionBarcodePostEntity extends BaseEntity {
  final String idBarcode;

  TransactionBarcodePostEntity({
    required this.idBarcode,
  });
}

class TransactionEntity extends BaseEntity {
  final int id;
  final DateTime? deadline;
  final User user;
  final int totalAmount;
  final String note;
  final DateTime? created;

  TransactionEntity(
      {required this.id,
      required this.deadline,
      required this.user,
      required this.totalAmount,
      required this.note,
      required this.created});
}
