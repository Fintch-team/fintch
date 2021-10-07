import 'package:fintch/gen_export.dart';

class TransactionRepository {
  final TransactionService moneyPlanService;

  TransactionRepository({
    required this.moneyPlanService,
  });

  Future<bool> postTransaction(
      {required TransactionPostEntity postEntity}) async {
    bool res = await moneyPlanService.postTransaction(
        idUserReceive: postEntity.idReceive,
        idUserPay: postEntity.idPay,
        amount: postEntity.amount);

    return res;
  }

  Future<bool> postTransactionBarcode(
      {required TransactionBarcodePostEntity postEntity}) async {
    bool res = await moneyPlanService.postTransactionBarcode(
      idBarcode: postEntity.idBarcode,
    );

    return res;
  }
}
