import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class TransactionService extends ApiService {
  TransactionService() : super('$kUrl/');

  Future<bool> postTransaction({
    required String idUserReceive,
    required String idUserPay,
    required int amount,
  }) async {
    try {
      final res = await dio.post('transaction', data: {
        'amount': amount,
      }, queryParameters: {
        'pay': idUserPay,
        'receive': idUserReceive,
      });

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
