import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';

class WalletService extends ApiService {
  WalletService() : super('$kUrl/');

  Future<WalletModel> getWalletId({
    required String id,
  }) async {
    final res = await dio.get(
      'wallet/$id',
    );

    return WalletModel.fromJson(res.data);
  }

  Future<ListWalletModel> getWalletAll() async {
    final res = await dio.get(
      'wallet',
    );

    return ListWalletModel.fromJson(res.data);
  }

  Future<bool> postWallet({
    required int walletAmount,
    required int barrierAmount,
    required int payAmount,
    required DateTime barrierExpired
  }) async {
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
  }

  Future<bool> putWallet({
    required String idWallet,
    required String idPay,
    required String idReceive,
    required int amount,
  }) async {
    final res = await dio.put(
      'wallet/$idWallet',
      data: {
        'id_pay': idPay,
        'id_receive': idReceive,
        'amount': amount,
      },
    );

    return res.statusCode == 200;
  }

  Future<bool> deleteWallet({
    required String idWallet,
  }) async {
    final res = await dio.delete(
      'wallet/$idWallet',
    );

    return res.statusCode == 204;
  }
}
