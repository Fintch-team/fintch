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

  Future<bool> postMoneyPlan(
      {required String deadline,
      required String idUser,
      required String totalAmount,
      required String name}) async {
    try {
      final res = await dio.post(
        'money-planning',
        data: {
          'name': name,
          'deadline': deadline,
          'id_user': idUser,
          'total_amount': totalAmount,
          'amount': 0
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
    required String name,
    required String deadline,
    required String idUser,
    required String totalAmount,
  }) async {
    try {
      final res = await dio.put(
        'money-planning/$idMoneyPlan',
        data: {
          'deadline': deadline,
          'id_user': idUser,
          'total_amount': totalAmount,
          'name': name,
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
