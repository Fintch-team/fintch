import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class WalletService extends ApiService {
  WalletService() : super('$kUrl/');

  Future<WalletModel> getWalletId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'wallet/$id',
      );

      return WalletModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListWalletModel> getWalletAll() async {
    try {
      final res = await dio.get(
        'wallet',
      );

      return ListWalletModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postWallet(
      {required int walletAmount,
      required int barrierAmount,
      required int payAmount,
      required DateTime barrierExpired}) async {
    try {
      final res = await dio.post(
        'wallet',
        data: {
          'wallet_amount': walletAmount,
          'barrier_amount': barrierAmount,
          'pay_amount': payAmount,
          'barrier_expired': barrierExpired,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putWallet(
      {required String idWallet,
      required int walletAmount,
      required int barrierAmount,
      required int payAmount,
      required DateTime barrierExpired}) async {
    try {
      final res = await dio.put(
        'wallet/$idWallet',
        data: {
          'wallet_amount': walletAmount,
          'barrier_amount': barrierAmount,
          'pay_amount': payAmount,
          'barrier_expired': barrierExpired,
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteWallet({
    required String idWallet,
  }) async {
    try {
      final res = await dio.delete(
        'wallet/$idWallet',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
