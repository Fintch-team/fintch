import 'package:fintch/gen_export.dart';

class TransactionRepository {
  final TransactionService transactionService;
  final LocalAuthService localAuthService;

  TransactionRepository({
    required this.transactionService,
    required this.localAuthService,
  });

  Future<TransactionEntity> postTransaction(
      {required TransactionPostEntity postEntity}) async {
    TransactionModel res = await transactionService.postTransaction(
        idUserReceive: postEntity.idReceive, amount: postEntity.amount);

    return DataMapper.transactionMapper(res);
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
    TransactionTopUpModel res = await transactionService.postTransactionTopUp(
      name: postEntity.name,
      amount: postEntity.amount,
    );

    return DataMapper.transactionTopUpMapper(res);
  }
}
