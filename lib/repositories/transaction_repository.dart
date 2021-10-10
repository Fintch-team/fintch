import 'package:fintch/gen_export.dart';

class TransactionRepository {
  final TransactionService transactionService;
  final LocalAuthService localAuthService;

  TransactionRepository({
    required this.transactionService,
    required this.localAuthService,
  });

  Future<bool> postTransaction(
      {required TransactionPostEntity postEntity}) async {
    bool res = await transactionService.postTransaction(
        idUserReceive: postEntity.idReceive,
        idUserPay: localAuthService.userId.toString(),
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

  Future<TransactionTopUpEntity> postTransactionTopUp(
      {required TransactionTopUpPostEntity postEntity}) async {
    TopUpModel res = await transactionService.postTransactionTopUp(
      name: postEntity.name,
      amount: postEntity.amount,
    );

    return DataMapper.topUpMapper(res);
  }
}
