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

      print(res.statusCode);
      print(res.statusMessage);

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
      required String barrierExpired}) async {
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
      required String barrierExpired}) async {
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

  Future<bool> postBarrierExpired({
    required String barrierAmount,
    required String barrierExpired,
  }) async {
    try {
      final res = await dio.post(
        'wallet/barrier-cash',
        data: {
          'barrier_amount': barrierAmount,
          'barrier_expired': barrierExpired,
        },
      );

      // print(res.statusCode);
      // print(res.statusMessage);

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> extendBarrierCash() async {
    try {
      final res = await dio.put(
        'wallet/barrier-expired',
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteBarrierCash() async {
    try {
      final res = await dio.delete(
        'wallet/barrier-expired',
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
