import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';

class TransactionService extends ApiService {
  TransactionService() : super('$kUrl/');

  Future<bool> postTransaction({
    required String idUserReceive,
    required String idUserPay,
    required int amount,
  }) async {
    final res = await dio.post(
      'transaction',
      data: {
        'amount': amount,
      },
      queryParameters: {
        'pay': idUserPay,
        'receive': idUserReceive,
      }
    );

    return res.statusCode == 200;
  }
}
