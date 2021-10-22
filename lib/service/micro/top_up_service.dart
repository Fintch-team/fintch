import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class TopUpService extends ApiService {
  TopUpService() : super('$kUrl/');

  Future<TopUpModel> getTopUpId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'top-up/$id',
      );

      return TopUpModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListTopUpModel> getTopUpAll() async {
    try {
      final res = await dio.get(
        'top-up',
      );

      return ListTopUpModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteTopUp({
    required String idTopUp,
  }) async {
    try {
      final res = await dio.delete(
        'top-up/$idTopUp',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
