import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class MoneyPlanService extends ApiService {
  MoneyPlanService() : super('$kUrl/');

  Future<MoneyPlanModel> getMoneyPlanId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'money-planning/$id',
      );

      return MoneyPlanModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListMoneyPlanModel> getMoneyPlanAll() async {
    try {
      final res = await dio.get(
        'money-planning',
      );

      return ListMoneyPlanModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postMoneyPlan({
    required DateTime deadline,
    required String idUser,
    required int totalAmount,
  }) async {
    try {
      final res = await dio.post(
        'money-planning',
        data: {
          'deadline': deadline,
          'id_user': idUser,
          'total_amount': totalAmount,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putMoneyPlan({
    required String idMoneyPlan,
    required DateTime deadline,
    required String idUser,
    required int totalAmount,
  }) async {
    try {
      final res = await dio.put(
        'money-planning/$idMoneyPlan',
        data: {
          'deadline': 'required',
          'id_user': 'required',
          'total_amount': 'required',
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteMoneyPlan({
    required String idMoneyPlan,
  }) async {
    try {
      final res = await dio.delete(
        'money-planning/$idMoneyPlan',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
