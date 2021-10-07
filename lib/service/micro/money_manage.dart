import 'package:dio/dio.dart';
import 'package:fintch/gen_export.dart';
import 'package:flutter/foundation.dart';

class MoneyManageService extends ApiService {
  MoneyManageService() : super('$kUrl/');

  Future<MoneyManageModel> getMoneyManageId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'money-management/$id',
      );

      return MoneyManageModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListMoneyManageModel> getMoneyManageAll() async {
    try {
      final res = await dio.get(
        'money-management',
      );

      return ListMoneyManageModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postIncomeMoneyManage({
    required String name,
    required int amount,
  }) async {
    try {
      final res = await dio.post(
        'money-management',
        data: {
          'name': name,
          'amount': amount,
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postOutcomeMoneyManage({
    required String name,
    required int amount,
    required String idMoneyManageItem,
  }) async {
    try {
      final res = await dio.post(
        'money-management',
        data: {
          'name': name,
          'amount': amount,
          'id_money_management_item': idMoneyManageItem
        },
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putMoneyManage({
    required String idMoneyManage,
    required String name,
    required int amount,
    required String idMoneyManageItem,
  }) async {
    try {
      final res = await dio.put(
        'money-management/$idMoneyManage',
        data: {
          'name': name,
          'amount': amount,
          'id_money_management_item': idMoneyManageItem
        },
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteMoneyManage({
    required String idMoneyManage,
  }) async {
    try {
      final res = await dio.delete(
        'money-management/$idMoneyManage',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<MoneyManageItemModel> getMoneyManageItemId({
    required String id,
  }) async {
    try {
      final res = await dio.get(
        'money-management-item/$id',
      );

      return MoneyManageItemModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<ListMoneyManageItemModel> getMoneyManageItemAll() async {
    try {
      final res = await dio.get(
        'money-management-item',
      );

      return ListMoneyManageItemModel.fromJson(res.data);
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postIncomeMoneyManageItem(
      {required String name, required int amount, required int percent}) async {
    try {
      final res = await dio.post(
        'money-management-item',
        data: {'name': name, 'amount': amount, 'percent': percent},
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> postOutcomeMoneyManageItem({
    required String name,
    required int amount,
    required int percent,
  }) async {
    try {
      final res = await dio.post(
        'money-management-item',
        data: {'name': name, 'amount': amount, 'percent': percent},
      );

      return res.statusCode == 201;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> putMoneyManageItem({
    required String idMoneyManageItem,
    required String name,
    required int amount,
    required int percent,
  }) async {
    try {
      final res = await dio.put(
        'money-management-item/$idMoneyManageItem',
        data: {'name': name, 'amount': amount, 'percent': percent},
      );

      return res.statusCode == 200;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }

  Future<bool> deleteMoneyManageItem({
    required String idMoneyManageItem,
  }) async {
    try {
      final res = await dio.delete(
        'money-management-item/$idMoneyManageItem',
      );

      return res.statusCode == 204;
    } on DioError catch (e) {
      debugPrint("error $e");
      throw e.error;
    }
  }
}
