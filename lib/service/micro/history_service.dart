import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/cupertino.dart';

class HistoryService extends ApiService {
  HistoryService() : super('$kUrl/');

  Future<HistoryModel> getHistoryId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'history/$id',
      );

      return HistoryModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListHistoryModel> getHistoryAll(
      {String idPay = '', String idReceive = ''}) async {
    try {
      // Map<String, dynamic> query = {
      //   if (idPay.isNotEmpty) 'pay': idPay,
      //   if (idReceive.isNotEmpty) 'receive': idReceive,
      // };

      final res = await dio.get(
        'history',
      );

      return ListHistoryModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postHistory({
    required String idPay,
    required String idReceive,
    required int amount,
  }) async {
    try {
      final res = await dio.post(
        'history',
        data: {
          'id_pay': idPay,
          'id_receive': idReceive,
          'amount': amount,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putHistory({
    required String idHistory,
    required String idPay,
    required String idReceive,
    required int amount,
  }) async {
    try {
      final res = await dio.put(
        'history/$idHistory',
        data: {
          'id_pay': idPay,
          'id_receive': idReceive,
          'amount': amount,
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteHistory({
    required String idHistory,
  }) async {
    try {
      final res = await dio.delete(
        'history/$idHistory',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
