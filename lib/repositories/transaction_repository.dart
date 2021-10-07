import 'package:fintch/gen_export.dart';

class TransactionRepository {
  final TransactionService transactionService;

  TransactionRepository({
    required this.transactionService,
  });

  Future<bool> postTransaction(
      {required TransactionPostEntity postEntity}) async {
    bool res = await transactionService.postTransaction(
        idUserReceive: postEntity.idReceive,
        idUserPay: postEntity.idPay,
        amount: postEntity.amount);

    return res;
  }

  Future<bool> postTransactionBarcode(
      {required TransactionBarcodePostEntity postEntity}) async {
    bool res = await transactionService.postTransactionBarcode(
      idBarcode: postEntity.idBarcode,
    );

    return res;
  }
}
