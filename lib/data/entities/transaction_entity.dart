import 'package:fintch/gen_export.dart';

class TransactionPostEntity extends BaseEntity {
  final String amount;
  // final String idPay;
  final String idReceive;

  TransactionPostEntity({
    required this.amount,
    // required this.idPay,
    required this.idReceive,
  });
}

class TransactionBarcodePostEntity extends BaseEntity {
  final String idBarcode;

  TransactionBarcodePostEntity({
    required this.idBarcode,
  });
}
