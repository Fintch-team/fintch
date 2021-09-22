import 'package:fintch/gen_export.dart';

class WalletPostEntity extends BaseEntity {
  final int walletAmount;
  final int barrierAmount;
  final int payAmount;
  final DateTime barrierExpired;

  WalletPostEntity(
      {required this.walletAmount,
      required this.barrierAmount,
      required this.payAmount,
      required this.barrierExpired});
}

class WalletPutEntity extends BaseEntity {
  final String idWallet;
  final int walletAmount;
  final int barrierAmount;
  final int payAmount;
  final DateTime barrierExpired;

  WalletPutEntity(
      {required this.idWallet,
      required this.walletAmount,
      required this.barrierAmount,
      required this.payAmount,
      required this.barrierExpired});
}

class WalletEntity extends BaseEntity {
  final int id;
  final int payAmount;
  final int barrierAmount;
  final int walletAmount;
  final DateTime? barrierExpired;

  WalletEntity(
      {required this.id,
      required this.payAmount,
      required this.barrierAmount,
      required this.walletAmount,
      required this.barrierExpired});
}
