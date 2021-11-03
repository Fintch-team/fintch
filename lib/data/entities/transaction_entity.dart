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

class TransactionTopUpPostEntity extends BaseEntity {
  final String name;
  final String amount;

  TransactionTopUpPostEntity({
    required this.name,
    required this.amount,
  });
}

class TransactionTopUpEntity extends BaseEntity {
  final String token;
  final String webUrl;
  final UserData user;

  TransactionTopUpEntity({
    required this.token,
    required this.webUrl,
    required this.user,
  });
}

class TransactionEntity extends BaseEntity {
  final int amount;
  final WalletData pay;
  final WalletData receive;

  TransactionEntity({
    required this.amount,
    required this.pay,
    required this.receive,
  });
}
