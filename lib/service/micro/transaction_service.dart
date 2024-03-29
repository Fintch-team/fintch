import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class TransactionService extends ApiService {
  TransactionService() : super('$kUrl/');

  Future<TransactionModel> postTransaction({
    required String idUserReceive,
    required String amount,
  }) async {
    try {
      final res = await dio.post('transaction', data: {
        'amount': amount,
      }, queryParameters: {
        'receive': idUserReceive,
      });

      // print(res.statusCode);

      return TransactionModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<TransactionModel> postTransactionBarcode({
    required String idBarcode,
  }) async {
    try {
      final res = await dio.post(
        'transaction/barcode',
        data: {
          'barcode': idBarcode,
        },
      );

      return TransactionModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<TransactionTopUpModel> postTransactionTopUp({
    required String name,
    required String amount,
  }) async {
    try {
      final res = await dio.post(
        'transaction/top-up',
        data: {
          'name': name,
          'total_price': amount,
        },
      );

      return TransactionTopUpModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
